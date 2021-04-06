import numpy as np
from pandas import read_csv
from sklearn.impute import SimpleImputer

dataframe = read_csv('ts_short_features.csv')
stroke_features = dataframe.values
imputer = SimpleImputer(strategy='mean')
imputer.fit(stroke_features)
stroke_features_fix = imputer.transform(stroke_features)
print(stroke_features_fix[2,:])

sff = np.asarray(stroke_features_fix)
np.savetxt("ts_short_features_fix.csv", sff, delimiter=",")

