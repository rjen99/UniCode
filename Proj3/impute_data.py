# Import scikit-learn dataset library
from sklearn import datasets, svm, metrics
from sklearn.model_selection import train_test_split
from sklearn.impute import KNNImputer
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load dataset
dat = pd.read_csv(open("newdata.csv"), header=None, na_values='nan')

# print(dat)


data = dat.values

imputer = KNNImputer()
imputer.fit(data)
Xtrans = imputer.transform(data)

np.savetxt("impute.csv", Xtrans)
