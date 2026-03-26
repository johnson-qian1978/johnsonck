# -*- coding: utf-8 -*-
"""
Windows 系统信息查看工具 - 台账专用版（增强版）
用于非涉密信息设备台账填写
功能：获取计算机硬件信息、USB 设备历史（含品牌识别）、打印机信息等
"""

import wmi
import psutil
import winreg
import socket
import datetime
import re
from pathlib import Path


class SystemInfoViewer:
    """Windows 系统信息查看器 - 台账专用版（增强版）"""
    
    def __init__(self):
        self.c = wmi.WMI()
    
    def get_computer_info(self):
        """获取计算机品牌、型号和序列号"""
        info = {}
        try:
            for computer_system in self.c.Win32_ComputerSystem():
                info['manufacturer'] = computer_system.Manufacturer
                info['model'] = computer_system.Model
                info['name'] = computer_system.Name
                info['total_memory'] = f"{int(computer_system.TotalPhysicalMemory) / (1024**3):.2f} GB"
        except Exception as e:
            info['error'] = str(e)
        
        try:
            for bios in self.c.Win32_BIOS():
                info['bios_serial'] = bios.SerialNumber.strip()
                info['bios_version'] = bios.Version
        except Exception as e:
            info['bios_error'] = str(e)
        
        try:
            for board in self.c.Win32_BaseBoard():
                info['board_serial'] = board.SerialNumber.strip()
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
    
    def get_usb_history(self):
        """获取 USB 设备使用历史（增强版 - 从注册表获取详细信息）"""
        usb_devices = []
        
        try:
            # 打开 USBSTOR 注册表项
            usb_key_path = r"SYSTEM\CurrentControlSet\Enum\USBSTOR"
            try:
                usb_key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, usb_key_path)
            except FileNotFoundError:
                return []  # 没有 USB 设备历史
            
            # 枚举所有 USB 存储设备
            i = 0
            while True:
                try:
                    device_name = winreg.EnumKey(usb_key, i)
                    device_key = winreg.OpenKey(usb_key, device_name)
                    
                    # 获取设备详细信息
                    j = 0
                    while True:
                        try:
                            sub_device = winreg.EnumKey(device_key, j)
                            sub_key = winreg.OpenKey(device_key, sub_device)
                            
                            # 尝试获取 FriendlyName（更友好的设备名称）
                            try:
                                friendly_name = winreg.QueryValueEx(sub_key, "FriendlyName")[0]
                            except:
                                friendly_name = device_name.split('&')[0] if '&' in device_name else device_name
                            
                            # 尝试获取 Manufacturer
                            try:
                                manufacturer = winreg.QueryValueEx(sub_key, "Manufacturer")[0]
                            except:
                                manufacturer = ""
                            
                            # 尝试获取 ParentIdPrefix（可能包含 VID/PID 信息）
                            try:
                                parent_prefix = winreg.QueryValueEx(sub_key, "ParentIdPrefix")[0]
                            except:
                                parent_prefix = ""
                            
                            usb_info = {
                                'device_name': friendly_name,
                                'full_name': f"{device_name}\\{sub_device}",
                                'serial': sub_device if sub_device != '0000' else 'N/A',
                                'manufacturer': manufacturer,
                                'parent_prefix': parent_prefix
                            }
                            
                            # 尝试获取最后连接时间
                            last_connect = self._get_usb_last_connect_time(sub_key)
                            usb_info['last_connect'] = last_connect
                            
                            usb_devices.append(usb_info)
                            winreg.CloseKey(sub_key)
                            j += 1
                        except OSError:
                            break
                    
                    winreg.CloseKey(device_key)
                    i += 1
                except OSError:
                    break
            
            winreg.CloseKey(usb_key)
            
            # 如果 FriendlyName 不可用，尝试从其他注册表位置获取
            if not usb_devices:
                usb_devices = self._get_usb_from_mount_points()
            
        except Exception as e:
            usb_devices.append({'error': f'获取失败：{str(e)}'})
        
        return usb_devices
    
    def _get_usb_last_connect_time(self, usb_key):
        """获取 USB 设备最后连接时间"""
        try:
            # 方法 1：尝试从 Properties 获取 LastInstall
            try:
                properties_key = winreg.OpenKey(usb_key, "Properties")
                last_install = winreg.QueryValueEx(properties_key, "LastInstall")[0]
                if last_install:
                    winreg.CloseKey(properties_key)
                    return last_install.strftime("%Y-%m-%d %H:%M:%S")
                winreg.CloseKey(properties_key)
            except:
                pass
            
            # 方法 2：尝试从 DeviceParameters 获取
            try:
                params_key = winreg.OpenKey(usb_key, "DeviceParameters")
                # 某些设备有 LastWriteTime
                last_write = winreg.QueryInfoKey(params_key)[2]
                if last_write:
                    dt = datetime.datetime.fromtimestamp(last_write)
                    winreg.CloseKey(params_key)
                    return dt.strftime("%Y-%m-%d %H:%M:%S")
                winreg.CloseKey(params_key)
            except:
                pass
            
            # 方法 3：使用键的最后修改时间
            try:
                last_write = winreg.QueryInfoKey(usb_key)[2]
                if last_write:
                    dt = datetime.datetime.fromtimestamp(last_write)
                    return dt.strftime("%Y-%m-%d %H:%M:%S")
            except:
                pass
            
        except Exception as e:
            pass
        
        return '未知'
    
    def _get_usb_from_mount_points(self):
        """从挂载点获取 USB 设备信息"""
        devices = []
        try:
            # 尝试从 HKLM\SYSTEM\MountedDevices 获取
            md_key_path = r"SYSTEM\MountedDevices"
            try:
                md_key = winreg.OpenKey(winreg.HKEY_LOCAL_MACHINE, md_key_path)
                
                i = 0
                while True:
                    try:
                        value_name = winreg.EnumValue(md_key, i)
                        if value_name[0].startswith('\\DosDevices\\'):
                            # 这是一个驱动器号
                            device_info = {
                                'device_name': value_name[0],
                                'serial': 'N/A',
                                'last_connect': '未知'
                            }
                            devices.append(device_info)
                        i += 1
                    except OSError:
                        break
                
                winreg.CloseKey(md_key)
            except:
                pass
        except Exception as e:
            pass
        
        return devices
    
    def get_printer_info(self):
        """获取打印机信息（区分虚拟和实体打印机）"""
        printers = []
        
        # 虚拟打印机关键词
        virtual_printer_keywords = [
            'PDF', 'XPS', 'OneNote', 'Fax', '传真', 
            'WPS PDF', 'Microsoft Print to PDF',
            'Adobe PDF', 'CutePDF', 'doPDF'
        ]
        
        try:
            for printer in self.c.Win32_Printer():
                printer_name = printer.Name
                
                # 判断是否为虚拟打印机
                is_virtual = any(keyword in printer_name.upper() for keyword in virtual_printer_keywords)
                
                # 只添加实体打印机
                if not is_virtual:
                    printer_info = {
                        'name': printer_name,
                        'type': '实体打印机',
                        'status': printer.PrinterStatus,
                        'default': '是' if printer.Default else '否',
                        'network': '是' if printer.Network else '否',
                        'driver': printer.DriverName if hasattr(printer, 'DriverName') else 'N/A'
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
    
    def get_network_info(self):
        """获取网络信息（区分有线/无线，只显示实际连接的）"""
        network_info = {
            'wired': [],  # 有线网卡
            'wireless': [],  # 无线网卡
            'virtual': [],  # 虚拟适配器
            'all_ips': []
        }
        
        # 有线网卡关键词
        wired_keywords = ['ETHERNET', 'PCI', 'GBE', 'GIGABIT', 'REALTEK', 'INTEL', 'KILLER']
        # 无线网卡关键词
        wireless_keywords = ['WIFI', 'WIRELESS', 'WLAN', '802.11', 'WI-FI']
        # 虚拟适配器关键词
        virtual_keywords = ['VIRTUAL', 'LOOPBACK', 'TAP', 'TUN', 'VMWARE', 'VIRTUALBOX', 'ATRUST', 'HYPER-V']
        
        try:
            interfaces = psutil.net_if_addrs()
            stats = psutil.net_if_stats()
            
            for interface_name, addresses in interfaces.items():
                interface_upper = interface_name.upper()
                
                # 判断网卡类型
                is_wired = any(kw in interface_upper for kw in wired_keywords) and not any(kw in interface_upper for kw in wireless_keywords)
                is_wireless = any(kw in interface_upper for kw in wireless_keywords)
                is_virtual = any(kw in interface_upper for kw in virtual_keywords) or 'LOOPBACK' in interface_upper or interface_name.startswith('aTrust')
                
                # 检查是否已连接
                is_connected = False
                if interface_name in stats:
                    is_connected = stats[interface_name].isup
                
                # 获取 MAC 地址
                mac_addr = None
                for addr in addresses:
                    if hasattr(addr, 'family') and addr.family == psutil.AF_LINK and addr.address:
                        mac_addr = addr.address
                        break
                
                # 获取 IP 地址
                ip_addrs = []
                for addr in addresses:
                    if hasattr(addr, 'family') and addr.family == socket.AF_INET:
                        if is_connected or addr.address != '127.0.0.1':  # 只显示已连接的或非回环地址
                            ip_addrs.append(addr.address)
                
                interface_info = {
                    'name': interface_name,
                    'mac': mac_addr if mac_addr else 'N/A',
                    'ips': ip_addrs,
                    'connected': is_connected
                }
                
                # 分类存储
                if is_virtual:
                    network_info['virtual'].append(interface_info)
                elif is_wireless:
                    network_info['wireless'].append(interface_info)
                elif is_wired:
                    network_info['wired'].append(interface_info)
                
                # 所有 IP
                for ip in ip_addrs:
                    network_info['all_ips'].append({
                        'interface': interface_name,
                        'ip': ip,
                        'type': '有线' if is_wired else ('无线' if is_wireless else '虚拟')
                    })
                    
        except Exception as e:
            network_info['error'] = str(e)
        
        return network_info
    
    def get_all_info(self):
        """获取所有系统信息"""
        return {
            'computer': self.get_computer_info(),
            'os': self.get_os_info(),
            'windows_install_time': self.get_windows_install_time(),
            'system_boot_time': self.get_system_boot_time(),
            'cpu': self.get_cpu_info(),
            'disks': self.get_disk_info(),
            'network': self.get_network_info(),
            'usb_history': self.get_usb_history(),
            'printers': self.get_printer_info()
        }


def main():
    """主函数"""
    print("=" * 70)
    print("Windows 系统信息查看工具 - 台账专用版（增强版）")
    print("=" * 70)
    
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
    
    # 打印网络信息（改进版）
    print("\n【网络信息】")
    network = info['network']
    
    print("  【有线网卡】")
    if network['wired']:
        for nic in network['wired']:
            status = "✓ 已连接" if nic['connected'] else "✗ 未连接"
            print(f"    {nic['name']} - {status}")
            print(f"      MAC: {nic['mac']}")
            if nic['ips']:
                print(f"      IP: {', '.join(nic['ips'])}")
    else:
        print("    无有线网卡")
    
    print("  【无线网卡】")
    if network['wireless']:
        for nic in network['wireless']:
            status = "✓ 已连接" if nic['connected'] else "✗ 未连接"
            print(f"    {nic['name']} - {status}")
            print(f"      MAC: {nic['mac']}")
            if nic['ips']:
                print(f"      IP: {', '.join(nic['ips'])}")
    else:
        print("    无无线网卡")
    
    # 打印 USB 历史
    print("\n【USB 设备历史】")
    if info['usb_history']:
        for i, usb in enumerate(info['usb_history'], 1):
            print(f"  USB 设备 {i}:")
            print(f"    设备名称：{usb.get('device_name', 'N/A')}")
            print(f"    制造商：{usb.get('manufacturer', 'N/A')}")
            print(f"    序列号：{usb.get('serial', 'N/A')}")
            print(f"    最后连接：{usb.get('last_connect', 'N/A')}")
    else:
        print("  未检测到 USB 存储设备历史记录")
    
    # 打印打印机信息
    print("\n【实体打印机】")
    if info['printers']:
        for printer in info['printers']:
            print(f"  • {printer.get('name', 'N/A')}")
            print(f"    默认：{printer.get('default', 'N/A')} | 网络：{printer.get('network', 'N/A')}")
    else:
        print("  未检测到实体打印机（虚拟打印机已过滤）")
    
    print("\n" + "=" * 70)
    print("信息获取完成！")
    print("=" * 70)
    
    return info


if __name__ == "__main__":
    main()
