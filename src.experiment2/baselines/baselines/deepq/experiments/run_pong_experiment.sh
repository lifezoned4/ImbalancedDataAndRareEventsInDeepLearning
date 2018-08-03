#!/bin/bash

date >> timestamps

num_steps=4000000
error_log=errors_on.run_pong_experiment.log

python ../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-latency 0 2>> $error_log &
python ../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-latency 1 2>> $error_log &
python ../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-latency 2 2>> $error_log &
python ../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-latency 3 2>> $error_log &
python ../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-latency 4 2>> $error_log &
python ../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 1 2>> $error_log &
python ../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 2 2>> $error_log &
wait

# alternate runs
mkdir LM2.run1
cd LM2.run1
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 2 2>> $error_log &
cd ..

mkdir LM2.run2
cd LM2.run2
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 2 2>> $error_log &
cd ..

mkdir LM2.run3
cd LM2.run3
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 2 2>> $error_log &
cd ..

mkdir LM2.run4
cd LM2.run4
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 2 2>> $error_log &
cd ..

mkdir LM2.run5
cd LM2.run5
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 2 2>> $error_log &
cd ..

mkdir LM2.run6
cd LM2.run6
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 2 2>> $error_log &
cd ..
wait

# alternate RNG runs
mkdir LM3.run1
cd LM3.run1
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 3 2>> $error_log &
cd ..

mkdir LM3.run2
cd LM3.run2
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 3 2>> $error_log &
cd ..

mkdir LM3.run3
cd LM3.run3
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 3 2>> $error_log &
cd ..

mkdir LM3.run4
cd LM3.run4
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 3 2>> $error_log &
cd ..

mkdir LM3.run5
cd LM3.run5
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 3 2>> $error_log &
cd ..

mkdir LM3.run6
cd LM3.run6
python ../../run_atari.py --env PongNoFrameskip-v4 --num-timesteps $num_steps --train-with-all-latency-mode 3 2>> $error_log &
cd ..
wait

date >> timestamps

bash ../enjoy_pong_experiment.sh

Rscript ../visualisation.R