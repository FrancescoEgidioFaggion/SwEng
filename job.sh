#!/bin/bash
#SBATCH --job-name=matrix_multiplication
#SBATCH --output=result.out
#SBATCH --error=result.err
#SBATCH --ntasks=2



module load singularity


export TNPDIR=$HOME/tmp
mkdir -p $TMPDIR

singularity exec --bind $TMPDIR:$TMPDIR matrix_multiplication.sif bash -c "export OMPI_MCA_tmpdir_base=$TMPDIR && mpirun -np 2 /SwEng/build/main"

