#!/bin/bash

# you should be in root of repo, else fail
rootpath=$(pwd)
# experiment 1
cd src.experiment1
exp1_data_dir=$(date +%Y%m%d_%H%M%S)
mkdir $exp1_data_dir
cd $exp1_data_dir
bash ../run_experiment1.sh
echo "run exp1"
cd ../..

# experiment 2
cd src.experiment2/baselines/baselines/deepq/experiments
exp1_data_dir=$(date +%Y%m%d_%H%M%S)
mkdir $exp1_data_dir
cd $exp1_data_dir
bash ../run_pong_experiment.sh
echo "run exp 2"
cd $rootpath

