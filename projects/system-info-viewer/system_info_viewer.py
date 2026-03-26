# -*- coding: utf-8 -*-
"""
Windows 系统信息查看工具
功能：获取计算机硬件信息、系统信息、网络信息等
"""

import wmi
import psutil
import uuid
import winreg
import subprocess
import socket
import datetime
import json
from pathlib import Path


class SystemInfoViewer:
    """Windows 系统信息查看器"""
    
    def __init__(self):
        self.c = wmi.WMI()
    
    def get_computer_info(self):
        """获取计算机品牌、型号和序列号"""
        info = {}
        try:
            for computer_system in self.c.Win32_ComputerSystem():
                info['manufacturer'] = computer_system.Manufacturer  # 计算机制造商
                info['model'] = computer_system.Model  # 计算机型号
                info['name'] = computer_system.Name
                info['total_memory'] = f"{int(computer_system.TotalPhysicalMemory) / (1024**3):.2f} GB"
        except Exception as e:
            info['error'] = str(e)
        
        try:
            for bios in self.c.Win32_BIOS():
                info['bios_serial'] = bios.SerialNumber.strip()  # BIOS 序列号
                info['bios_version'] = bios.Version
        except Exception as e:
            info['bios_error'] = str(e)
        
        try:
            for board in self.c.Win32_BaseBoard():
                info['board_serial'] = board.SerialNumber.strip()  # 主板序列号
                info['board_product'] = board.Product
        except Exception as e:
            info['board_error'] = str(e)
        
        return info
    
    def get_windows_install_time(self):
        """获取 Windows 安装时间"""
        try:
            key_path = r"SOFTWARE\Microsoft\Windows NT\CurrentVersion"
            key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, key_path)
            install_date = winreg.QueryValueEx(key, "InstallDate")[0]
            winreg.CloseKey(key)
            install_datetime = datetime.datetime.fromtimestamp(install_date)
            return install_datetime.strftime("%Y-%m-%d %H:%M:%S")
        except Exception as e:
            return f"获取失败：{str(e)}"
    
    def get_system_boot_time(self):
        """获取系统启动时间"""
        try:
            boot_time = psutil.boot_time()
            boot_datetime = datetime.datetime.fromtimestamp(boot_time)
            return boot_datetime.strftime("%Y-%m-%d %H:%M:%S")
        except Exception as e:
            return f"获取失败：{str(e)}"
    
    def get_disk_info(self):
        """获取硬盘信息"""
        disks = []
        try:
            for physical_disk in self.c.Win32_DiskDrive():
                disk_info = {
                    'model': physical_disk.Model,
                    'serial': physical_disk.SerialNumber.strip() if physical_disk.SerialNumber else 'N/A',
                    'size': f"{int(physical_disk.Size) / (1024**3):.2f} GB",
                    'interface': physical_disk.InterfaceType
                }
                disks.append(disk_info)
        except Exception as e:
            disks.append({'error': str(e)})
        
        return disks
    
    def get_mac_address(self):
        """获取 MAC 地址"""
        mac_addresses = []
        try:
            interfaces = psutil.net_if_addrs()
            for interface_name, addresses in interfaces.items():
                for address in addresses:
                    if address.family == psutil.AF_LINK and address.address:
                        mac_addresses.append({
                            'interface': interface_name,
                            'mac': address.address
                        })
        except Exception as e:
            mac_addresses.append({'error': str(e)})
        
        return mac_addresses
    
    def get_ip_address(self):
        """获取 IP 地址"""
        ip_info = []
        try:
            # 获取本地 IP
            hostname = socket.gethostname()
            local_ip = socket.gethostbyname(hostname)
            ip_info.append({'type': '本地 IP', 'address': local_ip})
            
            # 获取网络接口 IP
            interfaces = psutil.net_if_addrs()
            for interface_name, addresses in interfaces.items():
                for address in addresses:
                    if address.family == socket.AF_INET:
                        ip_info.append({
                            'interface': interface_name,
                            'type': 'IPv4',
                            'address': address.address,
                            'netmask': address.netmask if address.netmask else 'N/A'
                        })
        except Exception as e:
            ip_info.append({'error': str(e)})
        
        return ip_info
    
    def get_usb_history(self):
        """获取 USB 设备使用历史"""
        usb_devices = []
        try:
            for disk in self.c.Win32_DiskDrive():
                if "USB" in disk.InterfaceType or "usb" in disk.InterfaceType.lower():
                    usb_info = {
                        'model': disk.Model,
                        'serial': disk.SerialNumber.strip() if disk.SerialNumber else 'N/A',
                        'size': f"{int(disk.Size) / (1024**3):.2f} GB" if disk.Size else 'N/A'
                    }
                    usb_devices.append(usb_info)
        except Exception as e:
            usb_devices.append({'error': str(e)})
        
        return usb_devices
    
    def get_printer_info(self):
        """获取打印机信息"""
        printers = []
        try:
            for printer in self.c.Win32_Printer():
                printer_info = {
                    'name': printer.Name,
                    'status': printer.PrinterStatus,
                    'default': '是' if printer.Default else '否',
                    'network': '是' if printer.Network else '否'
                }
                printers.append(printer_info)
        except Exception as e:
            printers.append({'error': str(e)})
        
        return printers
    
    def get_cpu_info(self):
        """获取 CPU 信息"""
        cpus = []
        try:
            for cpu in self.c.Win32_Processor():
                cpu_info = {
                    'name': cpu.Name,
                    'cores': cpu.NumberOfCores,
                    'logical_processors': cpu.NumberOfLogicalProcessors,
                    'max_clock': f"{cpu.MaxClockSpeed} MHz"
                }
                cpus.append(cpu_info)
        except Exception as e:
            cpus.append({'error': str(e)})
        
        return cpus
    
    def get_os_info(self):
        """获取操作系统信息"""
        try:
            for os in self.c.Win32_OperatingSystem():
                os_info = {
                    'name': os.Caption,
                    'version': os.Version,
                    'architecture': os.OSArchitecture,
                    'install_date': os.InstallDate[:8] if os.InstallDate else 'N/A',
                    'last_boot': os.LastBootUpTime[:14] if os.LastBootUpTime else 'N/A'
                }
                return os_info
        except Exception as e:
            return {'error': str(e)}
    
    def get_all_info(self):
        """获取所有系统信息"""
        return {
            'computer': self.get_computer_info(),
            'os': self.get_os_info(),
            'windows_install_time': self.get_windows_install_time(),
            'system_boot_time': self.get_system_boot_time(),
            'cpu': self.get_cpu_info(),
            'disks': self.get_disk_info(),
            'network': {
                'mac_addresses': self.get_mac_address(),
                'ip_addresses': self.get_ip_address()
            },
            'usb_history': self.get_usb_history(),
            'printers': self.get_printer_info()
        }


def main():
    """主函数"""
    print("=" * 60)
    print("Windows 系统信息查看工具")
    print("=" * 60)
    
    viewer = SystemInfoViewer()
    info = viewer.get_all_info()
    
    # 打印计算机信息
    print("\n【计算机信息】")
    comp = info['computer']
    print(f"  制造商：{comp.get('manufacturer', 'N/A')}")
    print(f"  型号：{comp.get('model', 'N/A')}")
    print(f"  BIOS 序列号：{comp.get('bios_serial', 'N/A')}")
    print(f"  主板序列号：{comp.get('board_serial', 'N/A')}")
    print(f"  内存：{comp.get('total_memory', 'N/A')}")
    
    # 打印系统信息
    print("\n【系统信息】")
    os_info = info['os']
    print(f"  操作系统：{os_info.get('name', 'N/A')}")
    print(f"  版本：{os_info.get('version', 'N/A')}")
    print(f"  架构：{os_info.get('architecture', 'N/A')}")
    print(f"  Windows 安装时间：{info['windows_install_time']}")
    print(f"  系统启动时间：{info['system_boot_time']}")
    
    # 打印 CPU 信息
    print("\n【CPU 信息】")
    for i, cpu in enumerate(info['cpu'], 1):
        print(f"  CPU {i}: {cpu.get('name', 'N/A')}")
        print(f"    核心数：{cpu.get('cores', 'N/A')}")
        print(f"    逻辑处理器：{cpu.get('logical_processors', 'N/A')}")
    
    # 打印硬盘信息
    print("\n【硬盘信息】")
    for i, disk in enumerate(info['disks'], 1):
        print(f"  硬盘 {i}: {disk.get('model', 'N/A')}")
        print(f"    序列号：{disk.get('serial', 'N/A')}")
        print(f"    容量：{disk.get('size', 'N/A')}")
    
    # 打印网络信息
    print("\n【网络信息】")
    print("  MAC 地址:")
    for mac in info['network']['mac_addresses']:
        print(f"    {mac.get('interface', 'N/A')}: {mac.get('mac', 'N/A')}")
    print("  IP 地址:")
    for ip in info['network']['ip_addresses']:
        if 'interface' in ip:
            print(f"    {ip['interface']}: {ip.get('address', 'N/A')}")
        else:
            print(f"    {ip.get('type', 'N/A')}: {ip.get('address', 'N/A')}")
    
    # 打印 USB 历史
    print("\n【USB 设备历史】")
    if info['usb_history']:
        for i, usb in enumerate(info['usb_history'], 1):
            print(f"  USB {i}: {usb.get('model', 'N/A')}")
            print(f"    序列号：{usb.get('serial', 'N/A')}")
    else:
        print("  未检测到 USB 存储设备")
    
    # 打印打印机信息
    print("\n【打印机信息】")
    if info['printers']:
        for printer in info['printers']:
            print(f"  名称：{printer.get('name', 'N/A')}")
            print(f"    默认：{printer.get('default', 'N/A')}")
            print(f"    网络：{printer.get('network', 'N/A')}")
    else:
        print("  未检测到打印机")
    
    print("\n" + "=" * 60)
    print("信息获取完成！")
    print("=" * 60)
    
    return info


if __name__ == "__main__":
    main()
