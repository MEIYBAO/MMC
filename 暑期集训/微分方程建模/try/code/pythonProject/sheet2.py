import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# 设置中文不乱码
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False

# 读取“附件2”表格
data = pd.read_excel("A题附件.xls", sheet_name="附件2", engine='xlrd')  # ⚠️ 注意工作表名

# 转换为二维数组
array = data.to_numpy()

# 获取尺寸
height, width = array.shape

# 创建画布
fig, ax = plt.subplots(figsize=(8, 8))

# 绘制伪彩图
im = ax.imshow(array, cmap='jet',aspect='auto')  # 你也可以尝试 'viridis', 'jet', 'plasma' 等色表

#添加横纵坐标标签
ax.set_xlabel("角度位置序号", fontsize=12)
ax.set_ylabel("探测器序号", fontsize=12)

# 添加颜色条（图例）
cbar = plt.colorbar(im)
cbar.set_label("强度值")  # 可自定义单位

# 保存图像
plt.savefig("附件2信息.png", dpi=300, bbox_inches='tight')

# 显示图像
plt.show()
