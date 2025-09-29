import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

# ✅ 设置中文字体
plt.rcParams['font.sans-serif'] = ['SimHei']  # 中文黑体
plt.rcParams['axes.unicode_minus'] = False    # 负号正常显示

# 读取旧版Excel（.xls）
data = pd.read_excel("A题附件.xls", sheet_name="附件1", engine='xlrd')

# 转换为 NumPy 数组
array = data.to_numpy()

# 创建画布（初始为0，背景）
img = np.zeros_like(array)

# 将值为1的点赋值为1（显示为黄色）
img[array == 1] = 1

# 显示图像
plt.imshow(img, cmap='viridis')
plt.axis("on")

plt.savefig("附件1信息.png", dpi=300, bbox_inches='tight')

plt.show()
