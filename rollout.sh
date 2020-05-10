# Usage: ./rollout.sh CartPole-v0/ppo-basic.yaml

export FILE=$1
export DIRECTORY="${FILE%.*}"
export CHECKPOINT=$(ls -tr $DIRECTORY/ray_results/*/*/ | grep checkpoint | tail -n1)
export CHECKPOINT_TO_USE=$(find $DIRECTORY/ray_results | grep $CHECKPOINT | grep "tune_metadata" | head -n1 | awk -F'\.tune_metadata' '{print $1}')

mkdir -p $DIRECTORY/rollout/$CHECKPOINT

rllib rollout $CHECKPOINT_TO_USE --video-dir $DIRECTORY/rollout/$CHECKPOINT --out $DIRECTORY/rollout/$CHECKPOINT/rollouts.pkl --run $(cat $FILE | grep '  run:' | awk '{print $NF}') --env $(cat $FILE | grep '  env:' | awk '{print $NF}') --episodes 5
