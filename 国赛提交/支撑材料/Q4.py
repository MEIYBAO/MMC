import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import accuracy_score, recall_score,f1_score,average_precision_score,precision_recall_curve, roc_curve,roc_auc_score,confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

plt.rcParams['font.sans-serif'] = ['SimHei']  
plt.rcParams['axes.unicode_minus'] = False

data = pd.read_excel("附件.xlsx", sheet_name="女胎检测数据")
x13 = data[["孕妇BMI","原始读段数","在参考基因组上比对的比例","GC含量","13号染色体的Z值","X染色体的Z值","X染色体浓度"]]
x18 = data[["孕妇BMI","原始读段数","在参考基因组上比对的比例","GC含量","18号染色体的Z值","X染色体的Z值","X染色体浓度"]]
x21 = data[["孕妇BMI","原始读段数","在参考基因组上比对的比例","GC含量","21号染色体的Z值","X染色体的Z值","X染色体浓度"]]
y13 = data["染色体的非整倍体"].apply(lambda x: 1 if pd.notna(x) and '13' in str(x) else 0)
y18 = data["染色体的非整倍体"].apply(lambda x: 1 if pd.notna(x) and '18' in str(x) else 0)
y21 = data["染色体的非整倍体"].apply(lambda x: 1 if pd.notna(x) and '21' in str(x) else 0)

x13_train, x13_test, y13_train, y13_test = train_test_split(x13, y13, test_size=0.3, random_state=42)
x18_train, x18_test, y18_train, y18_test = train_test_split(x18, y18, test_size=0.3, random_state=42)
x21_train, x21_test, y21_train, y21_test = train_test_split(x21, y21, test_size=0.3, random_state=42)

scaler = StandardScaler()
x13_train_scaled = scaler.fit_transform(x13_train)
x13_test_scaled = scaler.transform(x13_test)
x18_train_scaled = scaler.fit_transform(x18_train)
x18_test_scaled = scaler.transform(x18_test)
x21_train_scaled = scaler.fit_transform(x21_train)
x21_test_scaled = scaler.transform(x21_test)

model13 = LogisticRegression(penalty='l2', C=1.0, solver='liblinear', random_state=42)
model13.fit(x13_train_scaled, y13_train)
model18 = LogisticRegression(penalty='l2', C=1.0, solver='liblinear', random_state=42)
model18.fit(x18_train_scaled, y18_train)
model21 = LogisticRegression(penalty='l2', C=1.0, solver='liblinear', random_state=42)
model21.fit(x21_train_scaled, y21_train)

y13_pred = model13.predict(x13_test_scaled)
y13_pred_proba = model13.predict_proba(x13_test_scaled)[:, 1]
y18_pred = model18.predict(x18_test_scaled)
y18_pred_proba = model18.predict_proba(x18_test_scaled)[:, 1]
y21_pred = model21.predict(x21_test_scaled)
y21_pred_proba = model21.predict_proba(x21_test_scaled)[:, 1]

accuracy_score13 = accuracy_score(y13_test, y13_pred)
print(f"13号染色体准确率: {accuracy_score13:.4f}")
accuracy_score18 = accuracy_score(y18_test, y18_pred)
print(f"18号染色体准确率: {accuracy_score18:.4f}")
accuracy_score21 = accuracy_score(y21_test, y21_pred)
print(f"21号染色体准确率: {accuracy_score21:.4f}")