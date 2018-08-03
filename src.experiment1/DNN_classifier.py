import tensorflow as tf
import pandas as pd
from collections import Counter
import numpy
from sklearn.model_selection import train_test_split
from imblearn.over_sampling import SMOTE
from imblearn.over_sampling import RandomOverSampler
from imblearn.under_sampling import RandomUnderSampler
from imblearn.under_sampling import EditedNearestNeighbours
from imblearn.combine import SMOTEENN
import sklearn

import os, sys

import argparse

# GPU Only part: BEAWARE Experiment fails when not enough VRAM is avalible
gpu_options = tf.GPUOptions(per_process_gpu_memory_fraction=0.02)
gpu_options.allow_growth = True
sess = tf.Session(config=tf.ConfigProto(gpu_options=gpu_options))
sess.__enter__()
# GPU Only part end

parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument("--method_type", type=str, default="Imbalanced", help="Method to use.")
parser.add_argument("--data_set", type=str, default="winequality", help="Dataset to use.")
parser.add_argument("--rnd_state", type=int, default=None, help="Random seed to use.")
parser.add_argument("--noDNN", type=int, default=0, help="Set to 1 if no DNN structure should be used")
parser.add_argument("--adult_file", type=str, default="orginal", help="Set to 1to25, 1to50, 1to100 if sampled data should be used")

args = parser.parse_args()

experiment_file_handle = "experiment_"+ args.data_set + "." + args.method_type
if args.data_set == "adult":
    experiment_file_handle = "experiment_"+ args.data_set + "." + args.adult_file + "." + args.method_type

print("Running", experiment_file_handle, "with number", args.rnd_state)

set_hidden_units = [1024, 512, 256, 128, 64, 32, 16, 8, 4]
if args.noDNN == 1:
    set_hidden_units = [1024]

if args.data_set == "winequality":
    df = pd.read_csv('../../data/winequality-white.csv')
    FEATURES = ["fixed_acidity", "volatile_acidity", "citric_acid", "residual_sugar", "chlorides", "free_sulfur_dioxide", "total_sulfur_dioxide", "density", "pH", "sulphates", "alcohol"]
    LABEL = "quality"
    columns = [tf.feature_column.numeric_column(k) for k in FEATURES]
    epochs=10
    batch_size=32
    set_learning_rate=0.0001
elif args.data_set == "parkinsons":
    df = pd.read_csv('../../data/parkinsons.data.csv')
    FEATURES = ["MDVP_Fo", "MDVP_Fhi", "MDVP_Flo", "MDVP_Jitter", "MDVP_Jitter_Abs", "MDVP_RAP", "MDVP_PPQ", "Jitter_DDP", "MDVP_Shimmer", "MDVP_Shimmer_dB", "Shimmer_APQ3", "Shimmer_APQ5", "MDVP_APQ",
                "Shimmer_DDA", "NHR", "HNR", "RPDE", "DFA", "spread1", "spread2", "D2", "PPE"]
    LABEL = "status"
    columns = [tf.feature_column.numeric_column(k) for k in FEATURES]
    epochs=10
    batch_size=4
    set_learning_rate=0.0001
elif args.data_set == "adult":
    def file_chooser(x):
        return {
            'orginal': '../../data/adult.data_orginal.csv',
            '1to25': '../../data/adult.data_1to25.csv',
            '1to50': '../../data/adult.data_1to50.csv',
            '1to100': '../../data/adult.data_1to100.csv',
            }[x]
    df = pd.read_csv(file_chooser(args.adult_file))
    FEATURES = ["age", "fnlwgt", "education_num","capital_gain","capital_loss","hours_per_week","workclass","education","marital_status","occupation","relationship","race","sex","native_country"]
    numeric_FEATURES = ["age", "fnlwgt", "education_num","capital_gain","capital_loss","hours_per_week"]
    categoric_FEATURES = [x for x in FEATURES if x not in numeric_FEATURES ]
    df[categoric_FEATURES] = df[categoric_FEATURES].astype('category')
    df[categoric_FEATURES] = df[categoric_FEATURES].apply(lambda x: x.cat.codes)
    columns = [tf.feature_column.numeric_column(k) for k in FEATURES]
    LABEL = "target"
    epochs=10
    batch_size=512
    set_learning_rate=0.0001

train, test = train_test_split(df, test_size=0.1, random_state=args.rnd_state)

train_features = train.loc[:, lambda df: FEATURES]

# class_id: 0 minority class_id: 1 majority
if args.data_set == "winequality":
    train_labels = train.loc[:, lambda df: LABEL].apply(lambda x: 0 if x <= 4 else 1)
elif args.data_set == "parkinsons":
    train_labels = train.loc[:, lambda df: LABEL]
elif args.data_set == "adult":
    train_labels = train.loc[:, lambda df: LABEL].apply(lambda x: 1 if x == " <=50K" or x == " <=50K." else 0)

set_weight_column = None
set_optimizer=tf.train.GradientDescentOptimizer(learning_rate=set_learning_rate)

if args.method_type == "SMOTE":
    sm = SMOTE()
    train_features, train_labels = sm.fit_sample(train_features.values, train_labels.values)
    train_features = pd.DataFrame(train_features, columns=FEATURES)
elif args.method_type == "SMOTEENN":
    sme = SMOTEENN()
    train_features, train_labels = sme.fit_sample(train_features.values, train_labels.values)
    train_features = pd.DataFrame(train_features, columns=FEATURES)
elif args.method_type == "ROS":
    ros = RandomOverSampler()
    train_features, train_labels = ros.fit_sample(train_features.values, train_labels.values)
    train_features = pd.DataFrame(train_features, columns=FEATURES)
elif args.method_type == "RUS":
    rus = RandomUnderSampler()
    train_features, train_labels = rus.fit_sample(train_features.values, train_labels.values)
    train_features = pd.DataFrame(train_features, columns=FEATURES)
elif args.method_type == "ENN":
    enn = EditedNearestNeighbours()
    train_features, train_labels = enn.fit_sample(train_features.values, train_labels.values)
    train_features = pd.DataFrame(train_features, columns=FEATURES)
elif args.method_type == "AdaGrad":
    set_optimizer=tf.train.AdagradOptimizer(learning_rate=set_learning_rate)
elif args.method_type == "CostSensitive":
    majority_slower = Counter(train_labels)[0]/Counter(train_labels)[1]
    minorty_booster = 1/majority_slower
    train_features["CostSensitive"] = train_labels.apply(lambda x: minorty_booster if x == 0 else 1)
    set_weight_column = "CostSensitive"
    columns.append(tf.feature_column.numeric_column("CostSensitive"))

test_features = test.loc[:, lambda df: FEATURES]
if args.data_set == "winequality":
    test_labels = test.loc[:, lambda df: LABEL].apply(lambda x: 0 if x <= 4 else 1)
elif args.data_set == "parkinsons":
    test_labels = test.loc[:, lambda df: LABEL]
elif args.data_set == "adult":
    test_labels = test.loc[:, lambda df: LABEL].apply(lambda x: 1 if x == " <=50K" or x == " <=50K." else 0)

if args.method_type == "CostSensitive":
    majority_slower = Counter(train_labels)[0]/Counter(train_labels)[1]
    minorty_booster = 1/majority_slower
    test_features["CostSensitive"] = test_labels.apply(lambda x: minorty_booster if x == 0 else 1)

assert Counter(test_labels)[0] > 0
assert Counter(test_labels)[1] > 0

estimator = tf.estimator.DNNClassifier(
    feature_columns=columns,
    hidden_units=set_hidden_units,
    n_classes=2,
    weight_column=set_weight_column,
    activation_fn=tf.nn.relu6,
    model_dir='models/' + experiment_file_handle + '/',
    optimizer=set_optimizer
    )

ds_features_label = tf.data.Dataset.from_tensor_slices((dict(train_features), train_labels))
ds_preperation = ds_features_label.shuffle(buffer_size=200000).batch(batch_size).repeat(epochs)

def input_fn_train():
    return ds_preperation.make_one_shot_iterator().get_next()

class _LoggerHook(tf.train.SessionRunHook):
    """Logs loss and runtime."""

    def begin(self):
        self.step = 0
        path = "loss.log/" + experiment_file_handle
        if not os.path.exists(path):
            os.makedirs(path)
        filename = path + "/" + str(args.rnd_state) + ".csv"
        self.f = open(filename, "w")
        self.f.write("step," + "loss" + "\n")
        self.loss = tf.losses.get_total_loss()

    def before_run(self, run_context):
        self.step+=1
        return tf.train.SessionRunArgs(self.loss)  # Asks for loss value.

    def after_run(self, run_context, run_values):
        if self.step % 10 == 1:
            loss_value = run_values.results
            self.f.write(str(self.step) + "," + str(loss_value/2) + "\n")

estimator.train(input_fn=input_fn_train,
                hooks=[
                    _LoggerHook()
                ])

ds_features = tf.data.Dataset.from_tensor_slices(dict(test_features))
ds_preperation = ds_features.batch(batch_size)

def input_fn_predict(): # returns x, y
    return ds_preperation.make_one_shot_iterator().get_next()

predictions = estimator.predict(input_fn=input_fn_predict)

pred_array = numpy.empty(len(test_labels))
class_ids = numpy.empty(len(test_labels))
for i, el in enumerate(predictions):
    class_id = el["class_ids"][0]
    pred_array[i] = el['probabilities'][class_id]
    class_ids[i] = class_id

auc = sklearn.metrics.roc_auc_score(test_labels.values, class_ids)
confusion_matrix =  sklearn.metrics.confusion_matrix(test_labels.values, class_ids)
tn, fp, fn, tp = confusion_matrix.ravel()

print(experiment_file_handle, confusion_matrix)
print(experiment_file_handle, "tn", tn)
print(experiment_file_handle, "fp", fp)
print(experiment_file_handle, "fn", fn)
print(experiment_file_handle, "tp", tp)
print(experiment_file_handle,"tpr (Recall)=", str(tp/(tp+fn)), "tnr (Specificity)=", str(tn/(tn+fp)))

f=open(experiment_file_handle + ".log", "a+")

print(experiment_file_handle, "AUC =", auc)
f.write(str(args.rnd_state) + "," + str(auc)+ "," + str(tp/(tp+fn)) + "," + str(tn/(tn+fp)) +  "\n")
