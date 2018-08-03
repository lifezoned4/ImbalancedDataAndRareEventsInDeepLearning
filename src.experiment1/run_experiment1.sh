#!/bin/bash

rm -rf loss.log

declare -a arr_nodnn=("" "--noDNN 1")
declare -a arr=("winequality" "parkinsons" "adult")
declare -a arr_adult=("1to25" "1to50" "1to100")

var=0

for NODNN in "${arr_nodnn[@]}"
do
  date >> timestamps
  mkdir $var
  cd $var
  let "var++"
  for run in {1..1000}
  do
    rm -rf models
    for dataset in "${arr[@]}"
    do
      python3 ../../DNN_classifier.py --data_set $dataset --method_type SMOTE --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set $dataset --method_type SMOTEENN --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set $dataset --method_type ROS --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set $dataset --method_type RUS --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set $dataset --method_type ENN --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set $dataset --method_type Imbalanced --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set $dataset --method_type AdaGrad --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set $dataset --method_type CostSensitive --rnd_state $run $NODNN &
    done
    wait
    for dataset_sub in "${arr_adult[@]}"
    do
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type SMOTE --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type SMOTEENN --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type ROS --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type RUS --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type ENN --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type Imbalanced --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type AdaGrad --rnd_state $run $NODNN &
      python3 ../../DNN_classifier.py --data_set adult --adult_file $dataset_sub --method_type CostSensitive --rnd_state $run $NODNN &
    done
    wait
  done
  Rscript ../../visualisation.R
  cd ..
done
date >> timestamps
