import os

# 获取脚本所在目录的绝对路径
script_dir = os.path.dirname(os.path.abspath(__file__))

# 使用绝对路径
input_file = os.path.join(script_dir, "memory.mem")
output_file = os.path.join(script_dir, "memory.coe")

# 添加文件存在性检查
if not os.path.exists(input_file):
    print(f"错误: 找不到文件 {input_file}")
    print(f"当前工作目录: {os.getcwd()}")
    print(f"脚本目录: {script_dir}")
    exit(1)

# 定义内存大小（假设 16KB 地址空间）
MEMORY_SIZE = 65536  # 16KB = 16384 bytes
memory = ["00000000"] * (MEMORY_SIZE // 4)  # 初始化为全 0，按字对齐

with open(input_file, "r") as mem_file:
    current_address = 0
    for line in mem_file:
        line = line.strip()
        if line.startswith("@"):  # 地址标记
            current_address = int(line[1:], 16) // 4  # 转换为字地址
        elif line and not line.startswith("//"):  # 非空行且非注释
            memory[current_address] = line  # 写入数据
            current_address += 1

# 写入 COE 文件
with open(output_file, "w") as coe_file:
    coe_file.write("memory_initialization_radix=16;\n")
    coe_file.write("memory_initialization_vector=\n")
    coe_file.write(",\n".join(memory) + ";\n")

print(f"转换完成：{input_file} -> {output_file}")