# Experimental Evaluation of Deep Learning on Imbalanced Data Sets and Training for Rare Events

The git repository for a Master Thesis at the University of Duisburg-Essen at the Department of "Modellierung Adaptiver Systeme".

## Experimental running guide:
Both experiments depend on Rscript, python 3.6 and needed following R libraries:

Do in your user/global R environment:

install.packages("tidyverse")
install.packages("scales")
install.packages("Hmisc")

## Experiment 1 (supervised experiment):
1. Copy code on a readwrite medium
2. Install dependencies
2.1 virtualenv -p $PATH_TO_PYTHON ./src.experiment1/
    source src.experiment1/bin/activate
2.2 pip3 install numpy
2.3 pip3 install tensorflow-gpu==1.8
2.4 pip3 install pandas
2.5 pip3 install sklearn
2.6 pip3 install imblearn
3. mkdir ./src.experiment1/<timestamp>.data
4. cd ./src.experiment1/<timestamp>.data
5. bash ../run_experiment1.sh
6. Yield results.

# Experiment 2 (DQN experiment):
1. Copy code on a readwrite medium
2. Install dependencies
2.1 virtualenv -p $PATH_TO_PYTHON ./src.experiment2/
    source src.experiment2/bin/activate
2.2 pip3 install numpy
2.3 pip3 install tensorflow-gpu==1.8
2.4 pip3 install atari_py
2.5 pip3 install 'gym.[atari]'==0.10.5
Note that baseline is monkey punched and is already in the repo
3.6 cd ./baselines/
4.7 pip3 install -e .
5. cd ./baselines/deepq/experiments/
6. mkdir ./<timestamp>.data
7. cd ./<timestamp>.data
8. bash ../run_pong_experiment.sh
9. Yield results.

# Experiment 1 and 2:

Option to run both experiments after each other (first experiment1, second experiment2):

1. Do both step 1 and step 2 from instructions from each experiment.
2. bash run_all_experiment.sh
3. enjoy the results in the folders mentioned in top part.

# Possible issues:
## Tensorflow in  CPU mode:
When no GPU is avalible you can install tensorflow in CPU mode
Replace step 1.3 in the experiments by
  pip3 install tensorflow==1.8

Be warned this probably takes ages.

## GPU VRAM is too small:
Experiments will fail when they not fit in VRAM. We tested only with 8 GB of VRAM.
When fewer VRAM is avalible the running scripts should be adjusted by hand to do smaller parallel runs of in each experimtn. (just put some 'wait' between the calls)