# trim paired end reads
# Info on the Trimmomatic tool available here:
# http://www.usadellab.org/cms/index.php?page=trimmomatic

# Naupaka Zimmerman
# November 6, 2017

# meant to run for paired reads based on name of forward read (ends in "_1.fastq")
for file in "$@"; do
	TrimmomaticPE -threads 8 -basein $file \
		-baseout data/trimmed/$(basename -s _1.fastq $file).trim.fastq \
		ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 \
		SLIDINGWINDOW:4:20 MINLEN:50 &
done
