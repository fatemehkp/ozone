#!/bin/bash
#set a job name  
#SBATCH --job-name=msfo3_count
#################  
#a file for job output, you can check job progress
#SBATCH --output=msfo3_count.out
#################
# a file for errors from the job
#SBATCH --error=msfo3_count.err
#################
#time you think you need; default is one day
#in minutes in this case, hh:mm:ss
#SBATCH --time=24:00:00
#################
#number of tasks you are requesting
#SBATCH -n 50
#SBATCH --exclusive
#SBATCH --mem=100G
################
#partition to use
#SBATCH --partition=short
#################
#number of nodes to distribute n tasks across
#SBATCH -N 1
#################

sas msfo3_count -work /scratch/fatemehkp/projects/Ozone/code

cd $work


sas msfo3_count


