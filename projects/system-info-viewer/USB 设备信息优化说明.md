# USB 设备信息获取优化说明

## 📋 问题描述

用户反馈 USB 设备信息显示问题：
1. **品牌识别**：所有设备都显示"未知品牌"
2. **最后连接时间**：所有设备都显示"未知"

## 🔍 原因分析

### 品牌识别问题
- 从注册表 `USBSTOR` 获取的设备名称通常是 `Disk` 或 `Other`，没有品牌信息
- 序列号格式复杂，难以直接识别品牌
- 缺少 VID/PID（厂商 ID/产品 ID）信息

### 最后连接时间问题
- Windows 不直接在 USBSTOR 注册表项中存储最后连接时间
- 需要从其他注册表位置获取（如 Properties\LastInstall）
- 部分 Windows 版本可能不记录此信息

## ✅ 优化方案

### 1. 品牌识别优化

#### 方法 1：从 FriendlyName 获取
```python
# 尝试获取 FriendlyName（更友好的设备名称）
try:
    friendly_name = winreg.QueryValueEx(sub_key, "FriendlyName")[0]
    # 例如："SanDisk Ultra USB Device"
except:
    friendly_name = device_name
```

#### 方法 2：从 Manufacturer 获取
```python
# 尝试获取制造商信息
try:
    manufacturer = winreg.QueryValueEx(sub_key, "Manufacturer")[0]
    # 例如："Samsung"
except:
    manufacturer = ""
```

#### 方法 3：增强品牌库（添加 VID/PID 识别）
```python
USB_VID_BRANDS = {
    'VID_04E8': '三星 (Samsung)',
    'VID_0781': '闪迪 (SanDisk)',
    'VID_0951': '金士顿 (Kingston)',
    'VID_05AC': '苹果 (Apple)',
    'VID_12D1': '华为 (Huawei)',
    # ... 更多 VID
}
```

#### 方法 4：从序列号特征识别
```python
# 闪迪序列号特征
if len(serial) == 24 and serial.startswith(('4C53', '2003')):
    return '闪迪 (SanDisk)'
# 金士顿序列号特征
if len(serial) == 16 and serial.startswith(('0101', '0001')):
    return '金士顿 (Kingston)'
```

### 2. 最后连接时间优化

#### 方法 1：从 Properties\LastInstall 获取
```python
try:
    properties_key = winreg.OpenKey(usb_key, "Properties")
    last_install = winreg.QueryValueEx(properties_key, "LastInstall")[0]
    return last_install.strftime("%Y-%m-%d %H:%M:%S")
except:
    pass
```

#### 方法 2：从注册表键的最后修改时间获取
```python
try:
    last_write = winreg.QueryInfoKey(usb_key)[2]
    if last_write:
        dt = datetime.datetime.fromtimestamp(last_write)
        return dt.strftime("%Y-%m-%d %H:%M:%S")
except:
    pass
```

#### 方法 3：从 DeviceParameters 获取
```python
try:
    params_key = winreg.OpenKey(usb_key, "DeviceParameters")
    last_write = winreg.QueryInfoKey(params_key)[2]
    if last_write:
        dt = datetime.datetime.fromtimestamp(last_write)
        return dt.strftime("%Y-%m-%d %H:%M:%S")
except:
    pass
```

## 📊 优化效果

### 优化前
```
设备名称 | 品牌     | 序列号                          | 最后连接
---------|----------|--------------------------------|----------
Disk     | 未知品牌 | E0D55E6C0EBE16B178AA13A3&0    | 未知
Disk     | 未知品牌 | 575842314131354E5A554531&0    | 未知
```

### 优化后（预期）
```
设备名称                    | 品牌          | 序列号                          | 最后连接
----------------------------|---------------|--------------------------------|-------------------
SanDisk Ultra USB Device    | 闪迪 (SanDisk)| 4C530001230456789012            | 2026-03-12 10:30:25
SAMSUNG USB Flash Drive     | 三星 (Samsung)| 0123456789ABCDEF                | 2026-03-11 14:20:15
Kingston DataTraveler       | 金士顿 (Kingston)| 010145d4c74e3d0f...          | 2026-03-10 09:15:30
```

## ⚠️ 限制说明

### 品牌识别限制
1. **老旧设备**：部分老旧 USB 设备可能没有 FriendlyName
2. **通用设备**：使用通用主控芯片的设备可能无法识别品牌
3. **白牌设备**：无品牌设备只能显示"未知品牌"

### 最后连接时间限制
1. **Windows 版本**：部分 Windows 版本不记录 LastInstall
2. **注册表清理**：如果清理过注册表，时间信息可能丢失
3. **首次连接**：首次连接的设备可能没有时间记录

## 📝 使用方法

**使用优化版本：**
```
SystemInfoViewer_GUI_v2_Fix2.exe
```

**或命令行版本：**
```
SystemInfoViewer_v2.exe
```

## 🔧 技术细节

### 注册表路径
- USB 存储设备：`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USBSTOR`
- USB 设备详情：`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\USB`
- 挂载点：`HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices`

### 时间格式
- LastInstall：FILETIME 格式（Windows 时间戳）
- 注册表修改时间：Unix 时间戳

### 品牌库规模
- USB 设备品牌：150+ 品牌
- VID 品牌映射：50+ VID
- 打印机品牌：60+ 品牌

---

**优化版本：** v2.0 Fix2  
**优化时间：** 2026-03-12  
**优化内容：** USB 设备品牌识别 + 最后连接时间获取
