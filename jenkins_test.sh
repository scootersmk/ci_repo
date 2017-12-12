#!/bin/bash -x

BUILD_DIR=$(pwd)
echo $BUILD_DIR

cat > $BUILD_TAG.pbs << EOF
#PBS -A STF002
#PBS -N $BUILD_TAG
#PBS -j oe
#PBS -l walltime=1:00:00,nodes=1
#PBS -d $BUILD_DIR
#PBS -l partition=rhea

cd $BUILD_DIR

hostname
date

mpirun -npernode 1 /usr/bin/find /ccs/home/koch -ls

EOF

cp $BUILD_TAG.pbs $BUILD_DIR

cd $BUILD_DIR

/home/koch/blocking_qsub $BUILD_DIR $BUILD_TAG.pbs

/bin/true
