import gym
import argparse
import csv

import time
import datetime

from collections import deque

from baselines import deepq
from baselines.common import set_global_seeds
from baselines.common.atari_wrappers import make_atari

def main():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--game_latency", type=int, default=0,help="Input-Latency used in game run.")
    parser.add_argument("--trained_with_latency", type=int, default=0, help="Input-Latency the model was trained with.")
    parser.add_argument("--trained_with_all_latency_mode", type=int, default=0, help="Input-Latency-All-Mode the model was trained with.")

    parser.add_argument("--game_runs", type=int, default=25, help="How offen the game should be ran.")

    args = parser.parse_args()

    prepath = ""
    if args.trained_with_all_latency_mode == 0:
        modelfile = "data.L" + str(args.trained_with_latency) + "/PongNoFrameskip-v4.L" + str(args.trained_with_latency) + ".pkl"
        csvfile = "data.L" + str(args.trained_with_latency)+ "/PongNoFrameskip-v4.L" + str(args.trained_with_latency) + ".pkl.on-L" + str(args.game_latency) + ".csv"
    else:
        modelfile =  "data.LM" + str(args.trained_with_all_latency_mode)+ "/PongNoFrameskip-v4.LM" + str(args.trained_with_all_latency_mode) + ".pkl"
        csvfile = "data.LM" + str(args.trained_with_all_latency_mode) + "/PongNoFrameskip-v4.LM" + str(args.trained_with_all_latency_mode) + ".pkl.on-L" + str(args.game_latency) + ".csv"

    modelfile = prepath + modelfile
    csvfile = prepath + csvfile

    env = make_atari("PongNoFrameskip-v4")
    env = deepq.wrap_atari_dqn(env)
    act = deepq.load(modelfile)

    with open(csvfile, 'w', newline='') as f:
        writer = csv.writer(f)
        writer.writerows([["Reward", "Time", "Frames"]])
        i = 0
        while i < args.game_runs:
            i+=1
            obs, done = env.reset(), False
            timeslice_start = datetime.datetime.now()
            frames = 0
            q_input = deque([0] * args.game_latency)

            episode_rew = 0
            while not done:
                # uncomment to analyse what the game is doing by your eye
                # env.render()
                # time.sleep(0.01)
                q_input.append(act(obs[None])[0])
                obs, rew, done, _ = env.step(q_input.popleft())
                frames+=1
                episode_rew += rew
            timespent = (datetime.datetime.now() - timeslice_start)
            writer.writerows([[episode_rew, timespent.total_seconds(), frames]])
            f.flush()
            print(str(episode_rew) + ", " + str(timespent.total_seconds()) + ", " + str(frames))

if __name__ == '__main__':
    main()
