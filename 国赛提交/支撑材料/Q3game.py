import pandas as pd
import numpy as np
from pygam import LinearGAM, s
import matplotlib.pyplot as plt
import os
os.environ["OMP_NUM_THREADS"] = "5"
from sklearn.cluster import KMeans

plt.rcParams['font.sans-serif'] = ['SimHei']  
plt.rcParams['axes.unicode_minus'] = False

file = "Q1data.xlsx"
back = pd.read_excel(file, header=None)
back.columns = ["年龄", "检测孕周", "孕妇BMI", "Y染色体浓度"]

rd = 1000
ndata = pd.DataFrame(columns=["年龄", "孕妇BMI", "预测的检测孕周"])
for i in range(rd):
    data = back
    data["Y染色体浓度"] = data["Y染色体浓度"]+np.random.normal(0, 0.1, len(back["Y染色体浓度"]))
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

    km = KMeans(n_clusters=5, n_init='auto')
    km.fit(result)
    center = km.cluster_centers_
    center = pd.DataFrame(center, columns=["年龄", "孕妇BMI", "预测的检测孕周"])
    center = center.sort_values(by="孕妇BMI", ascending=True)
    ndata = pd.concat([ndata,center],ignore_index=True)

ofile = "Q3datae.xlsx"
ndata.to_excel(ofile, index=False)