# -*- coding: utf-8 -*-
"""
USB 设备和打印机品牌识别库 - 增强版
包含 VID/PID 品牌映射和更智能的识别
"""

# USB 设备品牌识别库（基于设备名称关键词）
USB_BRANDS = {
    # 存储设备品牌
    'SAMSUNG': '三星 (Samsung)',
    'SANDISK': '闪迪 (SanDisk)',
    'SAN DISK': '闪迪 (SanDisk)',
    'KINGSTON': '金士顿 (Kingston)',
    'ADATA': '威刚 (ADATA)',
    'TRANSCEND': '创见 (Transcend)',
    'LEXAR': '雷克沙 (Lexar)',
    'PNY': '必恩威 (PNY)',
    'TEAM': '十铨 (Team Group)',
    'G.SKILL': '芝奇 (G.Skill)',
    'CORSAIR': '海盗船 (Corsair)',
    'CRUCIAL': '英睿达 (Crucial)',
    'WESTERN DIGITAL': '西部数据 (WD)',
    'WDC': '西部数据 (WD)',
    'TOSHIBA': '东芝 (Toshiba)',
    'SEAGATE': '希捷 (Seagate)',
    'HITACHI': '日立 (Hitachi)',
    'FUJITSU': '富士通 (Fujitsu)',
    'INTEL': '英特尔 (Intel)',
    'MICRON': '美光 (Micron)',
    'PHILIPS': '飞利浦 (Philips)',
    'SONY': '索尼 (Sony)',
    'PANASONIC': '松下 (Panasonic)',
    'HP': '惠普 (HP)',
    'HEWLETT-PACKARD': '惠普 (HP)',
    'DELL': '戴尔 (Dell)',
    'LENOVO': '联想 (Lenovo)',
    'ASUS': '华硕 (ASUS)',
    'ACER': '宏碁 (Acer)',
    'MSI': '微星 (MSI)',
    'GIGABYTE': '技嘉 (Gigabyte)',
    'ASROCK': '华擎 (ASRock)',
    'BIOSTAR': '映泰 (Biostar)',
    'EVGA': '艾维克 (EVGA)',
    'ZOTAC': '索泰 (Zotac)',
    'VERBATIM': '威宝 (Verbatim)',
    'MAXELL': '麦克赛尔 (Maxell)',
    'TDK': 'TDK',
    'IMATION': '怡敏信 (Imation)',
    'MEMOREX': '安耐美 (Memorex)',
    'BUFFALO': '巴法络 (Buffalo)',
    'I-O DATA': '艾欧数据 (I-O Data)',
    'LOGITEC': '罗技 (Logitec)',
    'ELECOM': '宜丽客 (Elecom)',
    'GREEN HOUSE': '绿屋 (Green House)',
    'SILICON POWER': '广颖电通 (Silicon Power)',
    'PATRIOT': '博帝 (Patriot)',
    'OCZ': 'OCZ',
    'MUSHKIN': '马什金 (Mushkin)',
    'SUPER TALENT': 'Super Talent',
    'SMARTBUY': 'Smartbuy',
    'GOODRAM': 'GoodRAM',
    'KINGMAX': '胜创 (Kingmax)',
    
    # 其他 USB 设备
    'LOGITECH': '罗技 (Logitech)',
    'RAZER': '雷蛇 (Razer)',
    'STEELSERIES': '赛睿 (SteelSeries)',
    'HYPERX': '金士顿 HyperX',
    'CREATIVE': '创新 (Creative)',
    'YAMAHA': '雅马哈 (Yamaha)',
    'BEHRINGER': '百灵达 (Behringer)',
    'PRESONUS': 'PreSonus',
    'M-AUDIO': 'M-Audio',
    'NATIVE INSTRUMENTS': 'NI (Native Instruments)',
    'AKAI': '雅佳 (Akai)',
    'NOVATION': 'Novation',
    'ARTURIA': 'Arturia',
    'KORG': '科格 (Korg)',
    'ROLAND': '罗兰 (Roland)',
    'BOSS': 'BOSS',
    'ZOOM': 'ZOOM',
    'TASCAM': '泰斯康 (Tascam)',
    'SHURE': '舒尔 (Shure)',
    'SENNHEISER': '森海塞尔 (Sennheiser)',
    'AUDIO-TECHNICA': '铁三角 (Audio-Technica)',
    'BEYERDYNAMIC': '拜亚动力 (Beyerdynamic)',
    'AKG': 'AKG',
    'JBL': 'JBL',
    'HARMAN': '哈曼 (Harman)',
    'BOSE': 'BOSE',
    'JABRA': '捷波朗 (Jabra)',
    'PLANTRONICS': '缤特力 (Plantronics)',
    'BLUE': 'Blue',
    'RODE': 'RODE',
    
    # 手机品牌（可能通过 USB 连接）
    'APPLE': '苹果 (Apple)',
    'IPHONE': '苹果 (Apple)',
    'HUAWEI': '华为 (Huawei)',
    'XIAOMI': '小米 (Xiaomi)',
    'MI': '小米 (Xiaomi)',
    'OPPO': '欧珀 (OPPO)',
    'VIVO': '维沃 (VIVO)',
    'HONOR': '荣耀 (Honor)',
    'ONEPLUS': '一加 (OnePlus)',
    'REALME': '真我 (Realme)',
    'GOOGLE': '谷歌 (Google)',
    'MOTOROLA': '摩托罗拉 (Motorola)',
    'NOKIA': '诺基亚 (Nokia)',
    'LG': 'LG',
    'HTC': '宏达电 (HTC)',
    'ZTE': '中兴 (ZTE)',
    'MEIZU': '魅族 (Meizu)',
    'COOLPAD': '酷派 (Coolpad)',
    'GIONEE': '金立 (Gionee)',
    'LEECO': '乐视 (LeEco)',
    '360': '360 手机',
    'NUBIA': '努比亚 (Nubia)',
    'BLACKBERRY': '黑莓 (BlackBerry)',
    
    # 主控芯片（可能出现在设备名中）
    'REALTEK': '瑞昱 (Realtek)',
    'VIA': '威盛 (VIA)',
    'JMICON': '智微 (JMicron)',
    'INITIO': 'Initio',
    'SUNPLUS': '凌阳 (Sunplus)',
    'GENESYS': '创惟 (Genesys)',
    'FEIYA': '飞雅',
    
    # 其他
    'GENERIC': '通用设备',
    'UNKNOWN': '未知品牌',
    'CHINA': '中国制造',
    'MADE IN CHINA': '中国制造',
}

# USB VID (Vendor ID) 品牌映射
# 格式：'VID_xxxx' -> 品牌名称
USB_VID_BRANDS = {
    'VID_04E8': '三星 (Samsung)',
    'VID_0781': '闪迪 (SanDisk)',
    'VID_0951': '金士顿 (Kingston)',
    'VID_13FE': '群联 (Phison)',
    'VID_1516': '威刚 (ADATA)',
    'VID_0930': '东芝 (Toshiba)',
    'VID_0480': '东芝 (Toshiba)',
    'VID_0BC2': '希捷 (Seagate)',
    'VID_1058': '西部数据 (WD)',
    'VID_05DC': '镁光 (Micron)',
    'VID_0204': '群联 (Phison)',
    'VID_1307': '群联 (Phison)',
    'VID_1908': '群联 (Phison)',
    'VID_0457': '威盛 (VIA)',
    'VID_0411': 'BUFFALO',
    'VID_046D': '罗技 (Logitech)',
    'VID_047F': '缤特力 (Plantronics)',
    'VID_045E': '微软 (Microsoft)',
    'VID_05AC': '苹果 (Apple)',
    'VID_12D1': '华为 (Huawei)',
    'VID_2717': '小米 (Xiaomi)',
    'VID_22B8': '摩托罗拉 (Motorola)',
    'VID_0BB4': 'HTC',
    'VID_0421': '诺基亚 (Nokia)',
    'VID_18D1': '谷歌 (Google)',
    'VID_0FCE': '索尼 (Sony)',
    'VID_04DA': '松下 (Panasonic)',
    'VID_0984': '威刚 (ADATA)',
    'VID_10EC': '瑞昱 (Realtek)',
    'VID_1B3C': '智微 (JMicron)',
    'VID_152D': '智微 (JMicron)',
    'VID_0080': '创惟 (Genesys)',
    'VID_17A0': '创惟 (Genesys)',
    'VID_0789': '创惟 (Genesys)',
    'VID_12D8': '创惟 (Genesys)',
    'VID_1A44': '创惟 (Genesys)',
    'VID_1308': '创惟 (Genesys)',
    'VID_05E3': '创惟 (Genesys)',
    'VID_174C': '智微 (JMicron)',
    'VID_1099': '三星 (Samsung)',
    'VID_04F2': '群联 (Phison)',
    'VID_090C': '群联 (Phison)',
    'VID_1B1C': '海盗船 (Corsair)',
    'VID_1B3C': '群联 (Phison)',
}

# 打印机品牌识别库
PRINTER_BRANDS = {
    # 主流打印机品牌
    'HP': '惠普 (HP)',
    'HEWLETT-PACKARD': '惠普 (HP)',
    'CANON': '佳能 (Canon)',
    'EPSON': '爱普生 (Epson)',
    'BROTHER': '兄弟 (Brother)',
    'LENOVO': '联想 (Lenovo)',
    'DELL': '戴尔 (Dell)',
    'SAMSUNG': '三星 (Samsung)',
    'XEROX': '施乐 (Xerox)',
    'RICOH': '理光 (Ricoh)',
    'KONICA MINOLTA': '柯尼卡美能达 (Konica Minolta)',
    'KYOCERA': '京瓷 (Kyocera)',
    'OKI': 'OKI',
    'SHARP': '夏普 (Sharp)',
    'TOSHIBA': '东芝 (Toshiba)',
    'FUJITSU': '富士通 (Fujitsu)',
    'PANASONIC': '松下 (Panasonic)',
    'LEXMARK': '利盟 (Lexmark)',
    'ZEBRA': '斑马 (Zebra)',
    'HONEYWELL': '霍尼韦尔 (Honeywell)',
    'DATAMAX': 'Datamax',
    'SATO': '佐藤 (SATO)',
    'TEC': '泰克 (TEC)',
    'GODEX': '科诚 (Godex)',
    'TSC': 'TSC',
    'ARGOX': '立象 (Argox)',
    'POSTEK': '博思得 (Postek)',
    'NIIMBOT': '精臣 (Niimbot)',
    'PHOMM': '精臣 (Phomm)',
    'LABELMAN': 'LabelManager',
    'DYMO': 'DYMO',
    'BRADY': '贝迪 (Brady)',
    'HELLER': '赫勒 (Heller)',
    
    # 3D 打印机品牌
    'CREALITY': '创想三维 (Creality)',
    'ANYCUBIC': '纵维立方 (Anycubic)',
    'ENDER': 'Ender (Creality)',
    'PRUSA': 'Prusa Research',
    'ULTIMAKER': 'Ultimaker',
    'MAKERBOT': 'MakerBot',
    'FLASHFORGE': '闪铸 (Flashforge)',
    'MONOPRICE': 'Monoprice',
    'QIDI': '启迪 (Qidi)',
    'WANHAO': '万豪 (Wanhao)',
    'TEVO': 'TEVO',
    'ANET': 'Anet',
    'TRONXY': 'Tronxy',
    'LONGER': 'Longer',
    'ELEGOO': 'ELEGOO',
    'PHROZEN': 'Phrozen',
    'FORMLABS': 'Formlabs',
    
    # 标签打印机
    'NIIMBOT': '精臣 (Niimbot)',
    'DYMO': 'DYMO',
    'BROTHER': '兄弟 (Brother)',
    'EPSON': '爱普生 (Epson)',
    'CANON': '佳能 (Canon)',
    'KINGJIM': '锦宫 (KingJim)',
    'CASIO': '卡西欧 (Casio)',
    'MAX': 'MAX',
    'PIPEMARK': 'Pipemark',
    
    # 其他
    'GENERIC': '通用设备',
    'UNKNOWN': '未知品牌',
}


def identify_usb_brand(device_name, serial_number=None, device_id=None):
    """
    识别 USB 设备品牌（增强版）
    
    Args:
        device_name: 设备名称
        serial_number: 序列号（可选）
        device_id: 设备 ID（包含 VID/PID，可选）
    
    Returns:
        品牌名称字符串
    """
    # 1. 首先尝试从 VID 识别
    if device_id:
        device_id_upper = device_id.upper()
        for vid, brand in USB_VID_BRANDS.items():
            if vid in device_id_upper:
                return brand
    
    # 2. 从设备名称识别
    if device_name:
        text_to_check = device_name.upper()
        for keyword, brand in USB_BRANDS.items():
            if keyword in text_to_check:
                return brand
    
    # 3. 从序列号特征识别（部分品牌有特定格式）
    if serial_number:
        serial_upper = serial_number.upper()
        # 闪迪序列号特征
        if len(serial_upper) == 24 and serial_upper.startswith(('4C53', '2003')):
            return '闪迪 (SanDisk)'
        # 金士顿序列号特征
        if len(serial_upper) == 16 and serial_upper.startswith(('0101', '0001')):
            return '金士顿 (Kingston)'
        # 三星序列号特征
        if len(serial_upper) >= 20 and ('SAMSUNG' in device_name.upper() if device_name else False):
            return '三星 (Samsung)'
    
    return '未知品牌'


def identify_printer_brand(printer_name):
    """
    识别打印机品牌
    
    Args:
        printer_name: 打印机名称
    
    Returns:
        品牌名称字符串
    """
    if not printer_name:
        return '未知品牌'
    
    text_to_check = printer_name.upper()
    
    # 遍历品牌库，查找匹配
    for keyword, brand in PRINTER_BRANDS.items():
        if keyword in text_to_check:
            return brand
    
    return '未知品牌'


def get_all_usb_brands():
    """获取所有 USB 设备品牌列表"""
    return list(set(USB_BRANDS.values()))


def get_all_printer_brands():
    """获取所有打印机品牌列表"""
    return list(set(PRINTER_BRANDS.values()))


if __name__ == '__main__':
    # 测试
    print("USB 品牌库测试:")
    print(f"  品牌数量：{len(USB_BRANDS)}")
    print(f"  VID 品牌数量：{len(USB_VID_BRANDS)}")
    print(f"  SAMSUNG -> {identify_usb_brand('SAMSUNG USB Device')}")
    print(f"  SanDisk -> {identify_usb_brand('SanDisk Ultra')}")
    print(f"  Kingston -> {identify_usb_brand('Kingston DataTraveler')}")
    print(f"  VID_04E8 -> {identify_usb_brand('USB Device', device_id='USB\\VID_04E8&PID_1234')}")
    
    print("\n打印机品牌库测试:")
    print(f"  品牌数量：{len(PRINTER_BRANDS)}")
    print(f"  HP -> {identify_printer_brand('HP LaserJet')}")
    print(f"  CANON -> {identify_printer_brand('Canon PIXMA')}")
    print(f"  EPSON -> {identify_printer_brand('Epson L3150')}")
