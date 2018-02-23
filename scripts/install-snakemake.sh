#!/usr/bin/env bash

set -e

if [ ! -e virtualenv-15.1.0/virtualenv.py ]
then
    wget https://github.com/pypa/virtualenv/archive/15.1.0.tar.gz
    tar -xzvf 15.1.0.tar.gz
fi

export PATH=`pwd`/virtualenv-15.1.0/:${PATH}

rm -r -f snakemake
git clone https://bitbucket.org/snakemake/snakemake.git
cd snakemake
virtualenv.py -p python3 .venv
source .venv/bin/activate
python setup.py install
