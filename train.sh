# Usage: ./train.sh CartPole-v0/ppo-basic.yaml

FILE=$1
DIRECTORY="${FILE%.*}"
mkdir -p $DIRECTORY/ray_results

rllib train -f $1
