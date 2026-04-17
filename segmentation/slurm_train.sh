#!/usr/bin/env bash

set -x

PARTITION="cpuonly"
#JOB_NAME=$2
CONFIG="configs/cityscapes/upernet_internimage_t_512x1024_160k_cityscapes.py"
GPUS=1
GPUS_PER_NODE=1
CPUS_PER_TASK=16
SRUN_ARGS=${SRUN_ARGS:-""}
PY_ARGS=${@:4}

PYTHONPATH="$(dirname $0)/..":$PYTHONPATH \
srun -p ${PARTITION} \
    -t 00:10:00 \
    --m 30000 \
    #--job-name=${JOB_NAME} \
    --gres=gpu:${GPUS_PER_NODE} \
    #--ntasks=${GPUS} \
    #--ntasks-per-node=${GPUS_PER_NODE} \
    --cpus-per-task=${CPUS_PER_TASK} \
    --quotatype=spot \
    --kill-on-bad-exit=1 \
    ${SRUN_ARGS} \
    python -u train.py ${CONFIG} --launcher="slurm" ${PY_ARGS}
