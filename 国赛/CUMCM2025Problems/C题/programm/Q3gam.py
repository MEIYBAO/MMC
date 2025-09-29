import pandas as pd
import numpy as np
from pygam import LinearGAM, s
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif'] = ['SimHei']  
plt.rcParams['axes.unicode_minus'] = False

file = "Q1data.xlsx"
data = pd.read_excel(file, header=None)
data.columns = ["年龄", "检测孕周", "孕妇BMI", "Y染色体浓度"]
x = data[["年龄", "孕妇BMI", "Y染色体浓度"]].values
y = data["检测孕周"].values
gam = LinearGAM(s(0) + s(1) + s(2)).fit(x, y)

data["Y染色体浓度"] = 0.04
new_data = pd.DataFrame({
    '年龄': data["年龄"],
    '孕妇BMI': data["孕妇BMI"],
    'Y染色体浓度': data["Y染色体浓度"]
})

prediction = gam.predict(new_data)

prediction = pd.Series(prediction, name="预测值")
select = data[["年龄", "孕妇BMI"]].copy()
result = select.copy()
result["预测的检测孕周"] = prediction.values
ofile = "Q3data.xlsx"
result.to_excel(ofile, index=False)