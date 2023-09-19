#!/bin/bash

Input=$1

left=$2

right=$3

echo "indivname: ${Input}.ind
snpname: ${Input}.snp
genotypename: ${Input}.geno
popleft: ${left}
popright: ${right}
details: YES
allsnps: YES
summary: YES" > qpWave_qpAdm_${Input}.par
