#!/bin/bash
#SBATCH -p accelerated
#SBATCH -n 1
#SBATCH -t 00:03:00
#SBATCH --mem=16G
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=16

set -e

echo "Running on $(hostname)"
echo "Date: $(date)"

# ---------------------------
# CUDA
# ---------------------------
module load devel/cuda/11.8

# ---------------------------
# CONDA (ONLY ONCE!)
# ---------------------------
source ~/miniconda3/etc/profile.d/conda.sh
conda activate /hkfs/work/workspace/scratch/ma_nilbecke-thesis/miniconda3/envs/t_env

# ---------------------------
# FORCE GCC toolchain (conda fallback)
# ---------------------------
export CC=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-gcc
export CXX=$CONDA_PREFIX/bin/x86_64-conda-linux-gnu-g++
export CUDAHOSTCXX=$CXX

unset CFLAGS
unset CXXFLAGS
unset CPATH
unset LD_LIBRARY_PATH

# ---------------------------
# FIX SETUPTOOLS BUG (IMPORTANT)
# ---------------------------
#pip install -U pip setuptools wheel
#pip install "setuptools<70" "packaging<24"

# ---------------------------
# GO TO CORRECT PATH
# ---------------------------
#cd $SLURM_SUBMIT_DIR/InternImage/segmentation/ops_dcnv3

rm -rf build

echo "Building DCNv3..."

python setup.py install

echo "Done"