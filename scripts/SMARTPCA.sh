#!/bin/bash

Input=$1

#Output=$2

#OutName=$3

echo "genotypename:    ${Input}.geno
snpname:         ${Input}.snp
indivname:       ${Input}.ind
evecoutname:	${Input}.pca.evec
evaloutname:	${Input}.eval
altnormstyle: NO
numoutevec: 10
numoutlieriter: 5
numoutlierevec: 10
lsqproject: YES
poplistname: pop_list.txt" > smartpca_${Input}.par

#smartpca -p $Input.par
