#!/usr/bin/env bash

CONFIG="configs/cityscapes/upernet_internimage_t_512x1024_160k_cityscapes.py"
GPUS=1
PORT=${PORT:-29300}

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
python -m torch.distributed.launch --nproc_per_node=$GPUS --master_port=$PORT \
    $(dirname "$0")/train.py $CONFIG --launcher pytorch ${@:3}
