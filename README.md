# Experimental Evaluation of Deep Learning on Imbalanced Data Sets and Training for Rare Events

Experimental running guide:
---------------------------
Both experiments depend on Rscript, python 3.6 and needed following R libraries:

Do in your user/global R environment:

install.packages("tidyverse")
install.packages("scales")
install.packages("Hmisc")

---------------------------
Experiment 1 (supervised experiment):
0. Copy code on a readwrite medium
1. Install dependencies
1.1 virtualenv -p $PATH_TO_PYTHON ./src.experiment1/
    source src.experiment1/bin/activate
1.2 pip3 install numpy
1.3 pip3 install tensorflow-gpu==1.8
1.4 pip3 install pandas
1.5 pip3 install sklearn
1.6 pip3 install imblearn
2. mkdir ./src.experiment1/<timestamp>.data
3. cd ./src.experiment1/<timestamp>.data
4. bash ../run_experiment1.sh
5. Yield results.
---------------------------

Experiment 2 (DQN experiment):
0. Copy code on a readwrite medium
1. Install dependencies
1.1 virtualenv -p $PATH_TO_PYTHON ./src.experiment2/
    source src.experiment2/bin/activate
1.2 pip3 install numpy
1.3 pip3 install tensorflow-gpu==1.8
1.4 pip3 install atari_py
1.5 pip3 install 'gym.[atari]'==0.10.5
Note that baseline is monkey punched and is already in the repo
1.6 cd ./baselines/
1.7 pip3 install -e .
3. cd ./baselines/deepq/experiments/
4. mkdir ./<timestamp>.data
5. cd ./<timestamp>.data
6. bash ../run_pong_experiment.sh
6.1 Rscript /src.experiment2/visualisation.R
7. Yield results.

---------------------------

Option to run both experiments after each other (first experiment1, second experiment2):

1. Do both step 0 and step 1 from instructions from each experiment.
2. bash run_all_experiment.sh
3. enjoy the results in the folders mentioned in top part.

---------------------------

Possible issues:
Tensorflow in  CPU mode:
------------------------
When no GPU is avalible you can install tensorflow in CPU mode
Replace step 1.3 in the experiments by
  pip3 install tensorflow==1.8

Be warned this probably takes ages.

GPU VRAM is too small:
----------------------
Experiments will fail when they not fit in VRAM. We tested only with 8 GB of VRAM.
When fewer VRAM is avalible the running scripts should be adjusted by hand to do smaller parallel runs of in each experimtn. (just put some 'wait' between the calls)