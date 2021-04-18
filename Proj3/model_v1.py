import tensorflow as tf
from tensorflow.keras.layers.experimental import preprocessing

import numpy as np
import matplotlib.pyplot as plt
from pandas import read_csv
import random

dataframe = read_csv('data\stroke_all_sampled.csv')
train = dataframe.values


r = random.randrange(len(train))
test = train[r,:]
train = np.delete(train,r,0)
print(len(train))
test_features = [test[0:7]]
test_features = np.asarray(test_features)
test_labels = [test[7]]
test_labels = np.asarray(test_labels)
train_features = train[:,0:7]
train_labels = train[:,7]
print(type(test_features))
print(type(train_features))

'''
dataframe = read_csv('data\stroke_train_sampled.csv')
test_features = dataframe.values[:,0:7]
test_labels = dataframe.values[:,7]
print(test_features[0:4,:])
dataframe = read_csv('data\stroke_test_sampled.csv')
train_features = dataframe.values[:,0:7]
train_labels = dataframe.values[:,7]
'''

feature_names = {'gender':0,'age':1,'hypertension':2,'heart disease':3,'avg glucose level':4,'bmi':5,'smokes':6}
chosen_features = [1,4,5]
test_features = test_features[:,chosen_features]
train_features = train_features[:,chosen_features]

train_features = np.where(train_features==float('nan'), 0, train_features)
test_features = np.where(test_features==float('nan'), 0, test_features)


test_labels = test_labels.astype(int)
train_labels = train_labels.astype(int)


model = tf.keras.Sequential([
    tf.keras.layers.Dense(8, activation='relu'),
    tf.keras.layers.Dense(2, activation='softmax')
])

model.compile(optimizer='adam',
              loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
              metrics=['accuracy'])

model.fit(train_features, train_labels, epochs=50, batch_size=32, verbose=0)#, validation_data=(test_features,test_labels))
test_loss, test_acc = model.evaluate(test_features, test_labels, verbose=2)
print('\nTest accuracy:', test_acc)
predictions = model.predict(test_features)


predictions = np.round(predictions[:,1])
print([predictions,test_labels])
conf_mat = tf.math.confusion_matrix(test_labels, predictions, num_classes=None, weights=None, dtype=tf.dtypes.int32, name=None)

print(conf_mat)

print('fin')