#!/usr/bin/env bash
# --------------------------------------------------------
# InternImage
# Copyright (c) 2022 OpenGVLab
# Licensed under The MIT License [see LICENSE for details]
# --------------------------------------------------------
#!/bin/bash
#SBATCH -p accelerated  # Use the dev_gpu_4_a100 partition with A100 GPUs dev_gpu_4
#SBATCH -n 1                   # Number of tasks (1 for single node)
#SBATCH -t 00:02:00            # Time limit (10 minutes for debugging purposes)
#SBATCH --mem=10000             # Memory request (adjust as needed)
#SBATCH --gres=gpu:1           # Request 1 GPU (adjust if you need more)
#SBATCH --cpus-per-task=16     # Number of CPUs per GPU (16 for A100)
#SBATCH --ntasks-per-node=1    # Number of tasks per node (1 in this case)

echo "Running on $(hostname)"
echo "Date: $(date)"

# Load CUDA (make sure version exists!)
module load devel/cuda/11.8

# Activate conda
source ~/miniconda3/etc/profile.d/conda.sh
conda activate /hkfs/work/workspace/scratch/ma_nilbecke-thesis/miniconda3/envs/t_env

echo "Python path:"
which python
python -c "import sys; print(sys.executable)"

echo "Python version:"
python --version

python setup.py build install
