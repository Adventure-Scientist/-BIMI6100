#!/bin/bash
#SBATCH --job-name=amy_assoc    ### Job Name
#SBATCH --output=/home/yourID/amy_assoc_%A_%a.out       ### File in which to store job output
#SBATCH --error=/home/yourID/amy_assoc_%A_%a.err        ### File in which to store job error messages
#SBATCH --array=1-22        ### array through autosomes
#SBATCH --qos=long          ### Quality of Service (like a queue in PBS)
#SBATCH --time=7-00:00:00     ### Wall clock time limit in Days-HH:MM:SS
#SBATCH --nodes=1             ### Node count required for the job
#SBATCH --ntasks-per-node=1   ### Number of tasks to be launched per Node
#SBATCH --mail-type=ALL
#SBATCH --mail-user=YOUREMAILADDRESS
#SBATCH --mem=128000

path="/lustre/project/crosslin/emerge/data/imputed_legacy/"
path2="/home/yourID/"
path3="/lustre/project/crosslin/bimi_6400/students/yourID/"

module load plink/1.9
##plink --vcf ${path}/chr22.dose.emerge_ids.consented.merged.vcf.gz --make-bed --out ${path2}emerge_chr22


date
plink \
--bfile ${path}emerge_chr${SLURM_ARRAY_TASK_ID} \
--pheno ${path2}amy_pheno.txt --1 \
--keep ${path2}amy_keep.txt \
--allow-no-sex \
--logistic \
 hide-covar \
--maf 0.01 \
--covar ${path2}amy_covar.txt  \
--covar-number 1-7 \
--out ${path3}chr${SLURM_ARRAY_TASK_ID}.hem.result
date

## - the covariates include sex, harv, and pcs 1-10
