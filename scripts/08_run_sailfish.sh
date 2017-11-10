#!/bin/bash

# script to run sailfish to count all reads from trimmed reads where
# both paired reads (F and R) made it through Trimmomatic QC

# Naupaka Zimmerman
# November 7, 2017

# Documentation is available here
# https://arxiv.org/pdf/1308.3700.pdf
# https://github.com/kingsfordgroup/sailfish
# see http://sailfish.readthedocs.io/en/master/sailfish.html
# and http://sailfish.readthedocs.io/en/master/library_type.html#fraglibtype
# for parameter details

# Also, since sailfish is conceptually very similar to salmon,
# this guide is also helpful:
# https://combine-lab.github.io/salmon/getting_started/

# call with bash 08_run_sailfish.sh data/trimmed/*.trim_1P.fastq
for sample in "$@"
do
	sampleID=$(basename -s .trim_1P.fastq $sample)
	echo "--------------------------------------------------"
	echo "Processing sample $sampleID"
	sailfish quant -i output/sailfish-index/ \
		-l IU \
		-1 data/trimmed/$sampleID.trim_1P.fastq \
		-2 data/trimmed/$sampleID.trim_2P.fastq \
		-o output/sailfish_quants/$sampleID \
		-p 88
done
