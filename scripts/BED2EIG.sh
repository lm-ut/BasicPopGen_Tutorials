#!/bin/bash

Input=$1

Output=$2

#OutName=$3

echo "genotypename:    ${Input}.bed
snpname:         ${Input}.bim
indivname:       ${Input}.fam
outputformat:    EIGENSTRAT
genotypeoutname: ${Output}.geno
snpoutname:      ${Output}.snp
indivoutname:    ${Output}.ind" > convertf_${Output}.par

#convertf -p $Input.par
