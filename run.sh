#!/usr/bin/env bash

set -e 

## a lightweight wrapper around snakemake

## e.g. run.sh all --dryrun

what=$1
what="${what:-all}"
other=$2

SCRIPT=$(readlink -f "$0")
SCRIPTPATH=$(dirname "$SCRIPT")
SNAKEMAKE="${SCRIPTPATH}/snakemake/.venv/bin/snakemake"
SNAKEFILE="${SCRIPTPATH}/snakefiles/Snakefile_main"

## check dependencies again
${SCRIPTPATH}/scripts/check-dependencies.sh

## TODO do this smarter
echo GATK=\'${GATK}\' > ${SCRIPTPATH}/snakefiles/Snakefile_environment
echo RESULTS_DIR=\'${RESULTS_DIR}\' >> ${SCRIPTPATH}/snakefiles/Snakefile_environment
echo LCIMPBENCH_HOME_DIR=\'`pwd`\' >> ${SCRIPTPATH}/snakefiles/Snakefile_environment
echo R=\'`which R`\' >> ${SCRIPTPATH}/snakefiles/Snakefile_environment

## put somewhere else, no space on home
ANALYSIS_DIR="${RESULTS_DIR}/"
LOG_DIR="${ANALYSIS_DIR}/logs/"
mkdir -p ${ANALYSIS_DIR}
mkdir -p ${LOG_DIR}

cd ${ANALYSIS_DIR}

${SNAKEMAKE} --snakefile ${SNAKEFILE} ${other} ${what} 
