#!/bin/bash
#SBATCH -p dev_cpuonly   # Use the dev_gpu_4_a100 partition with A100 GPUs dev_gpu_4
#SBATCH -n 1                   # Number of tasks (1 for single node)
#SBATCH -t 00:05:00            # Time limit (10 minutes for debugging purposes)
#SBATCH --mem=30000             # Memory request (adjust as needed)
##SBATCH --gres=gpu:1           # Request 1 GPU (adjust if you need more)
##SBATCH --cpus-per-task=16     # Number of CPUs per GPU (16 for A100)
##SBATCH --ntasks-per-node=1    # Number of tasks per node (1 in this case)

echo "Running on $(hostname)"
echo "Date: $(date)"

# Load CUDA (make sure version exists!)
module load devel/cuda/11.8

# Activate conda
source ~/miniconda3/etc/profile.d/conda.sh
conda activate thesis_env

echo "Python path:"
which python
python -c "import sys; print(sys.executable)"

echo "Python version:"
python --version

# Go to repo root (important for mmseg imports)
#cd ~/InternImage/segmentation   # <-- adjust to your repo path
python -u train.py ${configs/cityscapes/upernet_internimage_t_512x1024_160k_cityscapes.py} --launcher="slurm"
# Run training
#python train.py \
   # configs/cityscapes/upernet_internimage_t_512x1024_160k_cityscapes.py \
    #--work-dir work_dirs/exp1 \
    #--launcher pytorch