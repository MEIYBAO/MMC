import pandas as pd
import numpy as np
from pygam import LinearGAM, s
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif'] = ['SimHei']  
plt.rcParams['axes.unicode_minus'] = False

file = "Q1data.xlsx"
data = pd.read_excel(file, header=None)
data.columns = ["年龄", "检测孕周", "孕妇BMI", "Y染色体浓度"]
x = data[["年龄", "检测孕周", "孕妇BMI"]].values
y = data["Y染色体浓度"].values
gam = LinearGAM(s(0) + s(1) + s(2)).fit(x, y)
print("Pseudo R²:", gam.statistics_["pseudo_r2"])
fig, axs = plt.subplots(1, 3, figsize=(15, 5))
for i, term in enumerate(["年龄", "检测孕周", "孕妇BMI"]):
    xx = gam.generate_X_grid(term=i)
    axs[i].plot(xx[:, i], gam.partial_dependence(term=i, X=xx))
    axs[i].set_xlabel(term)
    axs[i].set_ylabel("贡献率")
    axs[i].set_title(f"{term}的效应")
plt.show()
