# convert paired-end sra files to fastq files
# Naupaka Zimmerman naupaka@gmail.com
# November 4, 2017

export PATH=$PATH:~/fastq-downloads/sratoolkit.2.8.2-1-ubuntu64/bin/

for sra_file in "$@"
do 
	echo Processing $sra_file
	fastq-dump.2.8.2 --outdir data/raw_data/fastq/ --split-files $sra_file &
done
