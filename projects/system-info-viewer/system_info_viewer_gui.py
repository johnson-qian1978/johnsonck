# -*- coding: utf-8 -*-
"""
Windows 系统信息查看工具 - GUI 版本
使用 PyQt5 创建图形界面
"""

import sys
import json
from datetime import datetime
from pathlib import Path
from PyQt5.QtWidgets import (QApplication, QMainWindow, QWidget, QVBoxLayout, 
                             QHBoxLayout, QTextEdit, QPushButton, QLabel, 
                             QTabWidget, QGroupBox, QTreeWidget, QTreeWidgetItem,
                             QMessageBox, QFileDialog)
from PyQt5.QtCore import Qt
from PyQt5.QtGui import QFont, QIcon

# 导入系统信息查看器
from system_info_viewer import SystemInfoViewer


class SystemInfoViewerGUI(QMainWindow):
    """系统信息查看器 GUI"""
    
    def __init__(self):
        super().__init__()
        self.viewer = SystemInfoViewer()
        self.current_info = None
        self.init_ui()
    
    def init_ui(self):
        """初始化界面"""
        self.setWindowTitle('Windows 系统信息查看工具')
        self.setGeometry(100, 100, 900, 700)
        
        # 创建中央部件
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        
        # 创建主布局
        main_layout = QVBoxLayout()
        central_widget.setLayout(main_layout)
        
        # 标题
        title_label = QLabel('🖥️ Windows 系统信息查看工具')
        title_label.setFont(QFont('Microsoft YaHei', 16, QFont.Bold))
        title_label.setAlignment(Qt.AlignCenter)
        main_layout.addWidget(title_label)
        
        # 创建选项卡
        self.tabs = QTabWidget()
        main_layout.addWidget(self.tabs)
        
        # 创建各个选项卡
        self.create_overview_tab()
        self.create_hardware_tab()
        self.create_network_tab()
        self.create_devices_tab()
        
        # 创建按钮区域
        button_layout = QHBoxLayout()
        
        self.refresh_btn = QPushButton('🔄 刷新信息')
        self.refresh_btn.clicked.connect(self.refresh_info)
        button_layout.addWidget(self.refresh_btn)
        
        self.save_btn = QPushButton('💾 保存结果')
        self.save_btn.clicked.connect(self.save_to_file)
        button_layout.addWidget(self.save_btn)
        
        self.export_json_btn = QPushButton('📄 导出 JSON')
        self.export_json_btn.clicked.connect(self.export_json)
        button_layout.addWidget(self.export_json_btn)
        
        self.exit_btn = QPushButton('❌ 退出')
        self.exit_btn.clicked.connect(self.close)
        button_layout.addWidget(self.exit_btn)
        
        main_layout.addLayout(button_layout)
        
        # 状态栏
        self.statusBar().showMessage('就绪')
        
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
        layout.addWidget(self.overview_text)
        
        self.tabs.addTab(tab, '📊 系统概览')
    
    def create_hardware_tab(self):
        """创建硬件选项卡"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)
        
        self.hardware_tree = QTreeWidget()
        self.hardware_tree.setHeaderLabels(['项目', '值'])
        self.hardware_tree.setColumnWidth(0, 300)
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
        layout.addWidget(self.network_text)
        
        self.tabs.addTab(tab, '🌐 网络信息')
    
    def create_devices_tab(self):
        """创建设备选项卡"""
        tab = QWidget()
        layout = QVBoxLayout()
        tab.setLayout(layout)
        
        self.devices_text = QTextEdit()
        self.devices_text.setReadOnly(True)
        self.devices_text.setFont(QFont('Consolas', 10))
        layout.addWidget(self.devices_text)
        
        self.tabs.addTab(tab, '📱 外部设备')
    
    def refresh_info(self):
        """刷新系统信息"""
        self.statusBar().showMessage('正在获取系统信息...')
        QApplication.processEvents()
        
        try:
            self.current_info = self.viewer.get_all_info()
            self.update_overview()
            self.update_hardware()
            self.update_network()
            self.update_devices()
            self.statusBar().showMessage('信息已更新')
        except Exception as e:
            QMessageBox.critical(self, '错误', f'获取信息失败：{str(e)}')
            self.statusBar().showMessage('获取信息失败')
    
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
        
        text = "【MAC 地址】\n"
        for mac in info['network']['mac_addresses']:
            text += f"  {mac.get('interface', 'N/A')}: {mac.get('mac', 'N/A')}\n"
        
        text += "\n【IP 地址】\n"
        for ip in info['network']['ip_addresses']:
            if 'interface' in ip:
                text += f"  {ip['interface']}: {ip.get('address', 'N/A')}\n"
            else:
                text += f"  {ip.get('type', 'N/A')}: {ip.get('address', 'N/A')}\n"
        
        self.network_text.setText(text)
    
    def update_devices(self):
        """更新设备信息"""
        info = self.current_info
        
        text = "【USB 设备历史】\n"
        if info['usb_history']:
            for i, usb in enumerate(info['usb_history'], 1):
                text += f"  {i}. {usb.get('model', 'N/A')}\n"
                text += f"     序列号：{usb.get('serial', 'N/A')}\n"
                text += f"     容量：{usb.get('size', 'N/A')}\n"
        else:
            text += "  未检测到 USB 存储设备\n"
        
        text += "\n【打印机】\n"
        if info['printers']:
            for printer in info['printers']:
                text += f"  • {printer.get('name', 'N/A')}\n"
                text += f"    默认：{printer.get('default', 'N/A')} | 网络：{printer.get('network', 'N/A')}\n"
        else:
            text += "  未检测到打印机\n"
        
        self.devices_text.setText(text)
    
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
                    f.write(self.devices_text.toPlainText())
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
    app = QApplication(sys.argv)
    
    # 设置应用程序样式
    app.setStyle('Fusion')
    
    window = SystemInfoViewerGUI()
    window.show()
    
    sys.exit(app.exec_())


if __name__ == '__main__':
    main()
