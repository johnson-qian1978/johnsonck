# -*- coding: utf-8 -*-
"""
Windows 系统信息查看工具 - GUI 版（台账专用）
支持 USB 设备和打印机品牌识别
修复：WMI 线程初始化问题
"""

import sys
import json
from datetime import datetime
from pathlib import Path
import pythoncom

# PyQt5 导入
try:
    from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                                 QHBoxLayout, QTextEdit, QPushButton, QLabel, 
                                 QTabWidget, QTreeWidget, QTreeWidgetItem,
                                 QMessageBox, QFileDialog, QProgressBar,
                                 QGroupBox, QSplitter, QTableWidget, QTableWidgetItem)
    from PyQt5.QtCore import Qt, QThread, pyqtSignal
    from PyQt5.QtGui import QFont, QIcon, QColor
    PYQT5_AVAILABLE = True
except ImportError:
    PYQT5_AVAILABLE = False
    print("错误：未安装 PyQt5，请运行：pip install PyQt5")

# 导入系统信息查看器和品牌库
from system_info_viewer_v2 import SystemInfoViewer
from device_brands import identify_usb_brand, identify_printer_brand


class SystemInfoWorker(QThread):
    """后台工作线程 - 修复 WMI 初始化问题"""
    finished = pyqtSignal(dict)
    error = pyqtSignal(str)
    
    def run(self):
        try:
            # 在线程中初始化 COM
            pythoncom.CoInitialize()
            
            viewer = SystemInfoViewer()
            info = viewer.get_all_info()
            
            # 添加品牌识别（增强版）
            for usb in info.get('usb_history', []):
                usb['brand'] = identify_usb_brand(
                    usb.get('device_name', ''),
                    usb.get('serial', ''),
                    usb.get('full_name', '')  # 包含 VID/PID 信息
                )
            
            for printer in info.get('printers', []):
                printer['brand'] = identify_printer_brand(
                    printer.get('name', '')
                )
            
            self.finished.emit(info)
        except Exception as e:
            self.error.emit(str(e))
        finally:
            # 清理 COM
            try:
                pythoncom.CoUninitialize()
            except:
                pass


class SystemInfoViewerGUI(QMainWindow):
    """系统信息查看器 GUI - 台账专用版"""
    
    def __init__(self):
        super().__init__()
        self.worker = None
        self.current_info = None
        self.init_ui()
    
    def init_ui(self):
        """初始化界面"""
        self.setWindowTitle('Windows 系统信息查看工具 - 台账专用版 v2.0')
        self.setGeometry(100, 100, 1000, 750)
        
        # 创建中央部件
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # 创建主布局
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        
        # 标题
        title_label = QLabel('🖥️ Windows 系统信息查看工具 - 台账专用版')
        title_label.setFont(QFont('Microsoft YaHei', 18, QFont.Bold))
        title_label.setAlignment(Qt.AlignCenter)
        title_label.setStyleSheet('color: #2196F3; padding: 10px;')
        main_layout.addWidget(title_label)
        
        # 创建选项卡
        self.tabs = QTabWidget()
        self.tabs.setFont(QFont('Microsoft YaHei', 10))
        main_layout.addWidget(self.tabs)
        
        # 创建各个选项卡
        self.create_overview_tab()
        self.create_hardware_tab()
        self.create_network_tab()
        self.create_usb_tab()
        self.create_printer_tab()
        
        # 创建按钮区域
        button_layout = QHBoxLayout()
        
        self.refresh_btn = QPushButton('🔄 刷新信息')
        self.refresh_btn.setFont(QFont('Microsoft YaHei', 11))
        self.refresh_btn.setStyleSheet('QPushButton { background-color: #4CAF50; color: white; padding: 8px 20px; } QPushButton:hover { background-color: #45a049; }')
        self.refresh_btn.clicked.connect(self.refresh_info)
        button_layout.addWidget(self.refresh_btn)
        
        self.save_btn = QPushButton('💾 保存结果')
        self.save_btn.setFont(QFont('Microsoft YaHei', 11))
        self.save_btn.setStyleSheet('QPushButton { background-color: #2196F3; color: white; padding: 8px 20px; } QPushButton:hover { background-color: #1976D2; }')
        self.save_btn.clicked.connect(self.save_to_file)
        button_layout.addWidget(self.save_btn)
        
        self.export_json_btn = QPushButton('📄 导出 JSON')
        self.export_json_btn.setFont(QFont('Microsoft YaHei', 11))
        self.export_json_btn.setStyleSheet('QPushButton { background-color: #FF9800; color: white; padding: 8px 20px; } QPushButton:hover { background-color: #F57C00; }')
        self.export_json_btn.clicked.connect(self.export_json)
        button_layout.addWidget(self.export_json_btn)
        
        button_layout.addStretch()
        
        self.exit_btn = QPushButton('❌ 退出')
        self.exit_btn.setFont(QFont('Microsoft YaHei', 11))
        self.exit_btn.setStyleSheet('QPushButton { background-color: #f44336; color: white; padding: 8px 20px; } QPushButton:hover { background-color: #d32f2f; }')
        self.exit_btn.clicked.connect(self.close)
        button_layout.addWidget(self.exit_btn)
        
        main_layout.addLayout(button_layout)
        
        # 状态栏
        self.statusBar().showMessage('就绪 - 点击"刷新信息"获取系统信息')
        self.statusBar().setFont(QFont('Microsoft YaHei', 9))
        
        # 进度条
        self.progress = QProgressBar()
        self.progress.setVisible(False)
        main_layout.addWidget(self.progress)
        
        # 初始加载信息
        self.refresh_info()
    
    def create_overview_tab(self):
        """创建概览选项卡"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)
        
        self.overview_text = QTextEdit()
        self.overview_text.setReadOnly(True)
        self.overview_text.setFont(QFont('Consolas', 10))
        self.overview_text.setStyleSheet('QTextEdit { background-color: #f5f5f5; border: 1px solid #ddd; padding: 5px; }')
        layout.addWidget(self.overview_text)
        
        self.tabs.addTab(tab, '📊 系统概览')
    
    def create_hardware_tab(self):
        """创建硬件选项卡"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)
        
        self.hardware_tree = QTreeWidget()
        self.hardware_tree.setHeaderLabels(['项目', '值'])
        self.hardware_tree.setColumnWidth(0, 350)
        self.hardware_tree.setFont(QFont('Microsoft YaHei', 10))
        self.hardware_tree.setStyleSheet('QTreeWidget { background-color: #ffffff; border: 1px solid #ddd; }')
        layout.addWidget(self.hardware_tree)
        
        self.tabs.addTab(tab, '🔧 硬件信息')
    
    def create_network_tab(self):
        """创建网络选项卡"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)
        
        self.network_text = QTextEdit()
        self.network_text.setReadOnly(True)
        self.network_text.setFont(QFont('Consolas', 10))
        self.network_text.setStyleSheet('QTextEdit { background-color: #f5f5f5; border: 1px solid #ddd; padding: 5px; }')
        layout.addWidget(self.network_text)
        
        self.tabs.addTab(tab, '🌐 网络信息')
    
    def create_usb_tab(self):
        """创建 USB 设备选项卡"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)
        
        # 创建表格
        self.usb_table = QTableWidget()
        self.usb_table.setColumnCount(4)
        self.usb_table.setHorizontalHeaderLabels(['设备名称', '品牌', '序列号', '最后连接'])
        self.usb_table.horizontalHeader().setStretchLastSection(True)
        self.usb_table.setColumnWidth(0, 200)
        self.usb_table.setColumnWidth(1, 150)
        self.usb_table.setColumnWidth(2, 250)
        self.usb_table.setColumnWidth(3, 150)
        self.usb_table.setFont(QFont('Microsoft YaHei', 10))
        self.usb_table.setStyleSheet('QTableWidget { background-color: #ffffff; border: 1px solid #ddd; }')
        self.usb_table.setAlternatingRowColors(True)
        layout.addWidget(self.usb_table)
        
        self.tabs.addTab(tab, '💾 USB 设备历史')
    
    def create_printer_tab(self):
        """创建打印机选项卡"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)
        
        # 创建表格
        self.printer_table = QTableWidget()
        self.printer_table.setColumnCount(5)
        self.printer_table.setHorizontalHeaderLabels(['打印机名称', '品牌', '默认', '网络', '状态'])
        self.printer_table.horizontalHeader().setStretchLastSection(True)
        self.printer_table.setColumnWidth(0, 250)
        self.printer_table.setColumnWidth(1, 150)
        self.printer_table.setColumnWidth(2, 80)
        self.printer_table.setColumnWidth(3, 80)
        self.printer_table.setColumnWidth(4, 150)
        self.printer_table.setFont(QFont('Microsoft YaHei', 10))
        self.printer_table.setStyleSheet('QTableWidget { background-color: #ffffff; border: 1px solid #ddd; }')
        self.printer_table.setAlternatingRowColors(True)
        layout.addWidget(self.printer_table)
        
        self.tabs.addTab(tab, '🖨️ 打印机信息')
    
    def refresh_info(self):
        """刷新系统信息"""
        self.statusBar().showMessage('正在获取系统信息...')
        self.progress.setVisible(True)
        self.progress.setRange(0, 0)  # 无限进度
        QApplication.processEvents()
        
        # 使用后台线程
        self.worker = SystemInfoWorker()
        self.worker.finished.connect(self.on_info_loaded)
        self.worker.error.connect(self.on_info_error)
        self.worker.start()
    
    def on_info_loaded(self, info):
        """信息加载完成"""
        self.current_info = info
        self.progress.setVisible(False)
        self.statusBar().showMessage('信息已更新')
        
        try:
            self.update_overview()
            self.update_hardware()
            self.update_network()
            self.update_usb()
            self.update_printer()
        except Exception as e:
            QMessageBox.critical(self, '错误', f'显示信息失败：{str(e)}')
    
    def on_info_error(self, error_msg):
        """信息加载错误"""
        self.progress.setVisible(False)
        self.statusBar().showMessage('获取信息失败')
        QMessageBox.critical(self, '错误', f'获取信息失败：{error_msg}')
    
    def update_overview(self):
        """更新概览信息"""
        info = self.current_info
        comp = info['computer']
        os_info = info['os']
        
        text = f"""
╔══════════════════════════════════════════════════════════╗
║                    系 统 概 览                            ║
╠══════════════════════════════════════════════════════════╣

【计算机信息】
  制造商：     {comp.get('manufacturer', 'N/A')}
  型号：       {comp.get('model', 'N/A')}
  BIOS 序列号：  {comp.get('bios_serial', 'N/A')}
  主板序列号：  {comp.get('board_serial', 'N/A')}
  内存：       {comp.get('total_memory', 'N/A')}

【操作系统】
  名称：       {os_info.get('name', 'N/A')}
  版本：       {os_info.get('version', 'N/A')}
  架构：       {os_info.get('architecture', 'N/A')}
  安装时间：   {info['windows_install_time']}
  启动时间：   {info['system_boot_time']}

【CPU】
"""
        for i, cpu in enumerate(info['cpu'], 1):
            text += f"  CPU {i}: {cpu.get('name', 'N/A')}\n"
            text += f"    核心：{cpu.get('cores', 'N/A')} | 线程：{cpu.get('logical_processors', 'N/A')}\n"
        
        text += f"\n【硬盘】\n"
        for i, disk in enumerate(info['disks'], 1):
            text += f"  {i}. {disk.get('model', 'N/A')} - {disk.get('size', 'N/A')}\n"
        
        usb_count = len(info.get('usb_history', []))
        printer_count = len(info.get('printers', []))
        
        text += f"\n【外设统计】\n"
        text += f"  USB 设备历史：{usb_count} 个\n"
        text += f"  实体打印机：{printer_count} 个\n"
        
        text += f"\n══════════════════════════════════════════════════════════\n"
        text += f"更新时间：{datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\n"
        
        self.overview_text.setText(text)
    
    def update_hardware(self):
        """更新硬件信息树"""
        self.hardware_tree.clear()
        info = self.current_info
        
        # CPU
        cpu_root = QTreeWidgetItem(self.hardware_tree, ['CPU', ''])
        for i, cpu in enumerate(info['cpu'], 1):
            QTreeWidgetItem(cpu_root, [f'CPU {i}', cpu.get('name', 'N/A')])
            QTreeWidgetItem(cpu_root, ['  核心数', str(cpu.get('cores', 'N/A'))])
            QTreeWidgetItem(cpu_root, ['  线程数', str(cpu.get('logical_processors', 'N/A'))])
        
        # 内存
        mem_root = QTreeWidgetItem(self.hardware_tree, ['内存', info['computer'].get('total_memory', 'N/A')])
        
        # 硬盘
        disk_root = QTreeWidgetItem(self.hardware_tree, ['硬盘', ''])
        for i, disk in enumerate(info['disks'], 1):
            disk_item = QTreeWidgetItem(disk_root, [f'硬盘 {i}', disk.get('model', 'N/A')])
            QTreeWidgetItem(disk_item, ['序列号', disk.get('serial', 'N/A')])
            QTreeWidgetItem(disk_item, ['容量', disk.get('size', 'N/A')])
        
        # 主板
        board_root = QTreeWidgetItem(self.hardware_tree, ['主板', ''])
        QTreeWidgetItem(board_root, ['产品', info['computer'].get('board_product', 'N/A')])
        QTreeWidgetItem(board_root, ['序列号', info['computer'].get('board_serial', 'N/A')])
        
        # BIOS
        bios_root = QTreeWidgetItem(self.hardware_tree, ['BIOS', ''])
        QTreeWidgetItem(bios_root, ['版本', info['computer'].get('bios_version', 'N/A')])
        QTreeWidgetItem(bios_root, ['序列号', info['computer'].get('bios_serial', 'N/A')])
        
        self.hardware_tree.expandAll()
    
    def update_network(self):
        """更新网络信息"""
        info = self.current_info
        network = info['network']
        
        text = "【有线网卡】\n"
        if network['wired']:
            for nic in network['wired']:
                status = "[已连接]" if nic['connected'] else "[未连接]"
                text += f"  {nic['name']} - {status}\n"
                text += f"    MAC: {nic['mac']}\n"
                if nic['ips']:
                    text += f"    IP: {', '.join(nic['ips'])}\n"
        else:
            text += "  无有线网卡\n"
        
        text += "\n【无线网卡】\n"
        if network['wireless']:
            for nic in network['wireless']:
                status = "[已连接]" if nic['connected'] else "[未连接]"
                text += f"  {nic['name']} - {status}\n"
                text += f"    MAC: {nic['mac']}\n"
                if nic['ips']:
                    text += f"    IP: {', '.join(nic['ips'])}\n"
        else:
            text += "  无无线网卡\n"
        
        text += "\n【虚拟适配器】\n"
        if network['virtual']:
            for nic in network['virtual']:
                text += f"  {nic['name']}\n"
                if nic['mac'] and nic['mac'] != 'N/A':
                    text += f"    MAC: {nic['mac']}\n"
        else:
            text += "  无虚拟适配器\n"
        
        self.network_text.setText(text)
    
    def update_usb(self):
        """更新 USB 设备表格"""
        info = self.current_info
        usb_devices = info.get('usb_history', [])
        
        self.usb_table.setRowCount(len(usb_devices))
        
        for i, usb in enumerate(usb_devices):
            # 设备名称
            name_item = QTableWidgetItem(usb.get('device_name', 'N/A'))
            self.usb_table.setItem(i, 0, name_item)
            
            # 品牌
            brand_item = QTableWidgetItem(usb.get('brand', '未知品牌'))
            brand_item.setForeground(Qt.blue)
            self.usb_table.setItem(i, 1, brand_item)
            
            # 序列号
            serial_item = QTableWidgetItem(usb.get('serial', 'N/A'))
            self.usb_table.setItem(i, 2, serial_item)
            
            # 最后连接
            connect_item = QTableWidgetItem(usb.get('last_connect', '未知'))
            self.usb_table.setItem(i, 3, connect_item)
    
    def update_printer(self):
        """更新打印机表格"""
        info = self.current_info
        printers = info.get('printers', [])
        
        self.printer_table.setRowCount(len(printers))
        
        for i, printer in enumerate(printers):
            # 名称
            name_item = QTableWidgetItem(printer.get('name', 'N/A'))
            self.printer_table.setItem(i, 0, name_item)
            
            # 品牌
            brand_item = QTableWidgetItem(printer.get('brand', '未知品牌'))
            brand_item.setForeground(Qt.blue)
            self.printer_table.setItem(i, 1, brand_item)
            
            # 默认
            default_item = QTableWidgetItem(printer.get('default', '否'))
            default_item.setTextAlignment(Qt.AlignCenter)
            self.printer_table.setItem(i, 2, default_item)
            
            # 网络
            network_item = QTableWidgetItem(printer.get('network', '否'))
            network_item.setTextAlignment(Qt.AlignCenter)
            self.printer_table.setItem(i, 3, network_item)
            
            # 状态
            status_item = QTableWidgetItem(str(printer.get('status', 'N/A')))
            self.printer_table.setItem(i, 4, status_item)
    
    def save_to_file(self):
        """保存结果到文本文件"""
        if not self.current_info:
            QMessageBox.warning(self, '警告', '请先刷新信息')
            return
        
        file_path, _ = QFileDialog.getSaveFileName(
            self, '保存结果', '', 'Text Files (*.txt);;All Files (*)'
        )
        
        if file_path:
            try:
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(self.overview_text.toPlainText())
                    f.write("\n\n")
                    f.write(self.network_text.toPlainText())
                    f.write("\n\n")
                    
                    # USB 设备
                    f.write("\n【USB 设备历史】\n")
                    for i in range(self.usb_table.rowCount()):
                        f.write(f"  设备 {i+1}:\n")
                        for j in range(4):
                            item = self.usb_table.item(i, j)
                            if item:
                                f.write(f"    {self.usb_table.horizontalHeaderItem(j).text()}: {item.text()}\n")
                    
                    # 打印机
                    f.write("\n【打印机信息】\n")
                    for i in range(self.printer_table.rowCount()):
                        f.write(f"  打印机 {i+1}:\n")
                        for j in range(5):
                            item = self.printer_table.item(i, j)
                            if item:
                                f.write(f"    {self.printer_table.horizontalHeaderItem(j).text()}: {item.text()}\n")
                
                QMessageBox.information(self, '成功', f'结果已保存到:\n{file_path}')
            except Exception as e:
                QMessageBox.critical(self, '错误', f'保存失败：{str(e)}')
    
    def export_json(self):
        """导出 JSON 文件"""
        if not self.current_info:
            QMessageBox.warning(self, '警告', '请先刷新信息')
            return
        
        file_path, _ = QFileDialog.getSaveFileName(
            self, '导出 JSON', '', 'JSON Files (*.json);;All Files (*)'
        )
        
        if file_path:
            try:
                with open(file_path, 'w', encoding='utf-8') as f:
                    json.dump(self.current_info, f, ensure_ascii=False, indent=2)
                QMessageBox.information(self, '成功', f'JSON 已导出到:\n{file_path}')
            except Exception as e:
                QMessageBox.critical(self, '错误', f'导出失败：{str(e)}')


def main():
    """主函数"""
    if not PYQT5_AVAILABLE:
        print("错误：PyQt5 未安装")
        print("请运行：pip install PyQt5")
        input("按回车键退出...")
        return
    
    app = QApplication(sys.argv)
    
    # 设置应用程序样式
    app.setStyle('Fusion')
    
    window = SystemInfoViewerGUI()
    window.show()
    
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
