lcimpbench
==========

Code to benchmark performance of low coverage imputation methods

### Run

```
git clone https://github.com/rwdavies/lcimpbench.git
cd lcimpbench
. activate ## requires python3, java, R to be in path, as well as GATK and RESULTS_DIR set. this sets them for my environment
./scripts/check-dependencies.sh ## see example activate script
./scripts/install-snakemake.sh
./scripts/all-tests.sh # stub

## to rebuild
rm summary.txt 
./run.sh "-j 16" ## -j gives number of jobs. can do --dryrun as well to see options
```

## minimal todo
* confirm licenses
* better dependency management (conda?)
* abstract out tool installation / use
* abstract out scenarios
* make output more comprehensive (e.g. split wrt allele frequency)
* make output r2 correct
* visualize output better
* increase robustness of sample download
* add test to check installation, tooling OK
* add in other tools (loimpute, STITCH when ready, etc)
* add null imputation tool to check r2 0 as appropriate
* add in other scenarios
* run multiple parameter options per tool
* run on VM / cloud / cluster
* auto run when committed to
* deal with edge / window / buffer effects
* handle multi-allelic SNPs
* handle indels