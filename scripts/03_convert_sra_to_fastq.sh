#!/bin/bash

# bash script to convert paired-end sra files to fastq files
# Naupaka Zimmerman naupaka@gmail.com
# November 4, 2017

# Call using "bash 03_convert_sra_to_fastq.sh path/to/sra_files/*.sra"

# add sra-toolkit tools to PATH
export PATH=$PATH:~/fastq-downloads/sratoolkit.2.8.2-1-ubuntu64/bin/

# convert files in parallel using a loop
# this process is definitely disk-speed limited
# the --split-files option makes seperate fastq files for the
# forward and reverse reads
# more documentation is available here:
# https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc&f=fastq-dump

for sra_file in "$@"
do
	echo Processing $sra_file
	fastq-dump.2.8.2 --outdir data/raw_data/fastq/ --split-files $sra_file &
done
