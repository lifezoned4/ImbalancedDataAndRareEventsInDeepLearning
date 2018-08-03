#!/bin/bash

runs=250
logdir=enjoy_pong_expreiment.gamerunning.log

date >> timestamps
for i in `seq 0 2`;
do
  echo "Run game models with game_latency $i"
  python ../enjoy_pong.py --game_latency $i --trained_with_latency 0 --game_runs $runs 2>> $logdir &
  python ../enjoy_pong.py --game_latency $i --trained_with_latency 1 --game_runs $runs 2>> $logdir &
  python ../enjoy_pong.py --game_latency $i --trained_with_latency 2 --game_runs $runs 2>> $logdir &
  python ../enjoy_pong.py --game_latency $i --trained_with_latency 3 --game_runs $runs 2>> $logdir &
  python ../enjoy_pong.py --game_latency $i --trained_with_latency 4 --game_runs $runs 2>> $logdir &
  python ../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 1  --game_runs $runs 2>> $logdir &
  wait

  # enjoy alternate
  cd LM2.run1
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 2  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM2.run2
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 2  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM2.run3
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 2  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM2.run4
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 2  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM2.run5
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 2  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM2.run6
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 2  --game_runs $runs 2>> $logdir &
  cd ..
  wait


  # enjoy alternateRNG
  cd LM3.run1
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 3  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM3.run2
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 3  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM3.run3
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 3  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM3.run4
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 3  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM3.run5
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 3  --game_runs $runs 2>> $logdir &
  cd ..

  cd LM3.run6
  python ../../enjoy_pong.py --game_latency $i --trained_with_all_latency_mode 3  --game_runs $runs 2>> $logdir &
  cd ..
  wait
done
date >> timestamps
