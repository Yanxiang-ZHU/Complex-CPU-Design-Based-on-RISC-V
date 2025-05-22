def coe_to_bin(coe_filename, bin_filename):
    with open(coe_filename, 'r') as coe_file:
        lines = coe_file.readlines()

    # 提取16进制数据
    hex_values = []
    for line in lines:
        # 去除注释、空白
        line = line.strip().lower()
        if not line or line.startswith(';') or '=' in line:
            continue
        # 移除末尾的分号或逗号
        line = line.replace(';', '').replace(',', '')
        if line:
            hex_values.append(line)

    # 将每个十六进制字符串转换为4字节并写入bin文件
    with open(bin_filename, 'wb') as bin_file:
        for hex_val in hex_values:
            val = int(hex_val, 16)
            bin_file.write(val.to_bytes(4, byteorder='little'))  # 小端写入
            # 如果你的平台是大端，请改为 byteorder='big'

    print(f"转换完成：{bin_filename}")

# 用法示例
coe_to_bin('dram.coe', 'dram.bin')

