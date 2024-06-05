#!/bin/bash
#SBATCH --job-name=matrix_multiplication
#SBATCH --output=result.out
#SBATCH --error=result.err
#SBATCH --ntasks=2

module load singularity
singularity exec matrix_multiplication.sif /SwEng/build/main matrixA.txt matrixB.txt

