import tensorflow as tf
from tensorflow.keras.layers.experimental import preprocessing

import numpy as np
import matplotlib.pyplot as plt
from pandas import read_csv
import random

'''
dataframe = read_csv('ts_stroke_features.csv')
test_features = dataframe.values
dataframe = read_csv('ts_stroke_labels.csv')
test_labels = dataframe.values
dataframe = read_csv('tr_stroke_features.csv')
train_features = dataframe.values
dataframe = read_csv('tr_stroke_labels.csv')
train_labels = dataframe.values
'''

dataframe = read_csv('data\stroke_train_sampled.csv')
test_features = dataframe.values[:,0:7]
test_labels = dataframe.values[:,7]
#print(test_features[0:4,:])
dataframe = read_csv('data\stroke_test_sampled.csv')
train_features = dataframe.values[:,0:7]
train_labels = dataframe.values[:,7]


feature_names = {'gender':0,'age':1,'hypertension':2,'heart disease':3,'avg glucose level':4,'bmi':5,'smokes':6}
chosen_features = [1,4,5]
test_features = test_features[:,chosen_features]
train_features = train_features[:,chosen_features]
print('heck')
print(type(train_labels))

train_features = np.where(train_features==float('nan'), 0, train_features)
test_features = np.where(test_features==float('nan'), 0, test_features)
print(test_features)
'''
normalizer = preprocessing.Normalization()
normalizer.adapt(np.array(train_features))
test_features = normalizer(test_features)
train_features = normalizer(train_features)
'''
test_labels = test_labels.astype(int)
train_labels = train_labels.astype(int)
print(len(test_features))
print(len(test_labels))

model = tf.keras.Sequential([
    tf.keras.layers.Dense(8, activation='relu'),
    tf.keras.layers.Dense(2, activation='softmax')
])

model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])

model.fit(train_features, train_labels, epochs=50, batch_size=32, validation_data=(test_features,test_labels))
test_loss, test_acc = model.evaluate(test_features, test_labels, verbose=2)
print('\nTest accuracy:', test_acc)
predictions = model.predict(test_features)


predictions = np.round(predictions[:,1])
print([predictions,test_labels])
conf_mat = tf.math.confusion_matrix(test_labels, predictions, num_classes=None, weights=None, dtype=tf.dtypes.int32, name=None)

print(conf_mat)

print('fin')