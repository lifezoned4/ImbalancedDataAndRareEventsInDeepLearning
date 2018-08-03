# Experimental Evaluation of Deep Learning on Imbalanced Data Sets and Training for Rare Events
Experimental part of master thesis at the university of Duisburg-Essen at the department of "Modellierung Adaptiver Systeme". Read the thesis for further understanding of the experiments.

# Experimental running guide:
Both experiments depend on Rscript, python 3.6 and needed following R libraries.

Do this in your user/global R environment:
```R
install.packages("tidyverse")
install.packages("scales")
install.packages("Hmisc")
```

## Experiment 1 (supervised experiment):
1. Copy code on a read-write medium (skip if you git clone)
2. Install dependencies
    1. Create a virtual python environment and active it.
    ```bash
    virtualenv -p python3 ./src.experiment1/
    source src.experiment1/bin/activate
    ```
    2. Install numpy.
    ```bash
    pip3 install -U numpy==1.14.5
    ```
    3. Install tensorflow in GPU mode and check if it runs correctly.
    (Beware of addition steps need in GPU mode. You need proprietary libraries from e.g. Nvidia )
    ```bash
    pip3 install -U tensorflow-gpu==1.8
    python -c "import tensorflow as tf; print(tf.__version__)"
    ```
    4. Install pandas.
    ```bash
    pip3 install -U pandas
    ```
    5. Install scikit-learn.
    ```bash
    pip3 install -U sklearn
    ```
    6. Install imbalanced-learn.
    ```bash
    pip3 install -U imblearn
    ```
3. Create a new directory which will contain the results.
```bash
mkdir ./src.experiment1/<timestamp>.data
```
4. Change directory to the data folder.
```bash
cd ./src.experiment1/<timestamp>.data
```
5. Run the core experiment (will take approximately more than 24h).
```bash
bash ../run_experiment1.sh
```
6. Yield results.

## Experiment 2 (DQN experiment):
1. Copy code on a read-write medium (skip if you git clone)
2. Install dependencies
    1. Create a virtual python environment and activate it.
    ```bash
    virtualenv -p python3 ./src.experiment1/
    source src.experiment1/bin/activate
    ```
    2. Install numpy.
    ```bash
    pip3 install -U numpy==1.14.5
    ```
    3. Install tensorflow in GPU mode and check if it runs correctly.
    (Beware of addition steps need in GPU mode. You need proprietary libraries from e.g. Nvidia )
    ```bash
    pip3 install -U tensorflow-gpu==1.8
    python -c "import tensorflow as tf; print(tf.__version__)"
    ```
    4. Install atari_py. It is needed by gym.
    ```bash
    pip3 install -U atari_py
    ```
    4. Install OpenAI gym.
    ```bash
    pip3 install -U gym==0.10.5
    ```
    6. Install OpenAI baselines. Note that baselines is monkey punched and is already in the repository.
    ```bash
    cd ./src.experiment2/baselines/
    pip3 install -U -e .
    ```
3. Create a new directory which will contain the results.
```bash
mkdir ./baselines/deepq/experiments/<timestamp>.data
```
4. Change directory to the data folder.
```bash
cd ./baselines/deepq/experiments/<timestamp>.data
```
5. Run the core experiment (will take approximately more than 24h).
```bash
bash ../run_pong_experiment.sh
```
6. Yield results.

# Experiment 1 and 2:

Option to run both experiments after each other (first experiment1, second experiment2):

1. Do both step 1 and step 2 from instructions from each experiment.
2. Run script (takes more than 48h)
```bash
bash run_all_experiment.sh
```
3. enjoy the results in the folders mentioned in top part.

# Possible issues:
## Tensorflow in  CPU mode:
When no GPU is available you can install tensorflow in CPU mode
Replace step 1.3 in the experiments by

```bash
pip3 install -U tensorflow==1.8
```

Be warned that running the experiment on CPU takes ages.

## GPU VRAM is too small:
Experiments will fail when they not fit in VRAM. We tested only with 8 GB of VRAM.
When fewer VRAM is available the running scripts should be adjusted by hand to do smaller parallel runs of in each experiment. (just put some 'wait' between the calls)