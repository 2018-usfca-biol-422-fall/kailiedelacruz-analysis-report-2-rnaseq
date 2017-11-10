#!/bin/bash

# trim paired end reads
# Info on the Trimmomatic tool available here:
# http://www.usadellab.org/cms/index.php?page=trimmomatic
# https://github.com/timflutre/trimmomatic

# Naupaka Zimmerman
# November 6, 2017

# call script like so: "bash 06_trimmomatic.sh data/fastq/*_1.fastq"
# meant to run for paired reads based on name of forward
# read (ends in "_1.fastq"), which determines how variants of output are
# determined
for file in "$@"
do
	# extract sample ID from file name
	SAMPLE=$(basename -s _1.fastq $file)

	# check if output file for given input already exists
	# if not, run Trimmomatic
	# we have to do this because only so many threads can use Java at once
	# so after running 06_trimmomatic.sh, there remain a bunch of files that are
	# not yet trimmed. The `if` statement checks if a given input already has
	# output files, and if it does not, then it trims it
	if [ `ls data/trimmed | grep -c $SAMPLE` -eq 0 ]
	then
		TrimmomaticPE -threads 8 -basein $file \
		  -baseout data/trimmed/$(basename -s _1.fastq $file).trim.fastq \
		  ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
		  SLIDINGWINDOW:4:20 MINLEN:50 &
	fi
done
