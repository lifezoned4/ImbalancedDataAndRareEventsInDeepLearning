from baselines import deepq
from baselines.common import set_global_seeds
from baselines import bench
import argparse
from baselines import logger
from baselines.common.atari_wrappers import make_atari

def main():
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('--env', help='environment ID', default='BreakoutNoFrameskip-v4')
    parser.add_argument('--seed', help='RNG seed', type=int, default=0)
    parser.add_argument('--prioritized', type=int, default=1)
    parser.add_argument('--dueling', type=int, default=1)
    parser.add_argument('--num-timesteps', type=int, default=int(10e6))
    parser.add_argument('--train-with-latency', type=int, default=0)
    parser.add_argument('--train-with-all-latency-mode', type=int, default=0)
    args = parser.parse_args()
    loggerid = "L" +  (("M" + str(args.train_with_all_latency_mode)) if (args.train_with_all_latency_mode != 0) else str(args.train_with_latency))
    loggerdir = "./data." + loggerid + "/"
    logger.configure(dir=loggerdir)
    set_global_seeds(args.seed)
    env = make_atari(args.env)
    env = bench.Monitor(env, logger.get_dir())
    env = deepq.wrap_atari_dqn(env)
    model = deepq.models.cnn_to_mlp(
        convs=[(32, 8, 4), (64, 4, 2), (64, 3, 1)],
        hiddens=[256],
        dueling=bool(args.dueling),
    )
    act = deepq.learn(
        env,
        q_func=model,
        lr=1e-4,
        max_timesteps=args.num_timesteps,
        buffer_size=10000,
        exploration_fraction=0.1,
        exploration_final_eps=0.01,
        train_freq=4,
        learning_starts=10000,
        target_network_update_freq=1000,
        gamma=0.99,
        prioritized_replay=bool(args.prioritized),
        print_freq=1,
        train_with_latency=args.train_with_latency,
        train_with_all_latency_mode=args.train_with_all_latency_mode
    )
    act.save(loggerdir + args.env + "." + loggerid + ".pkl")
    env.close()


if __name__ == '__main__':
    main()
