mkdir -p data/raw_data output/fastqc data/trimmed

# the pipe and tail -n +2 is a handy way to exclude the first line
for SRA_number in $(cut -f 10 data/metadata/ERP001058_SraRunTable.txt | tail -n +2)
do
	fastq-dump.2.8.2 -v $SRA_number -O data/raw_data
done

echo fastqc data/raw_data/*.fastq --outdir=output/fastqc

# Info on the Trimmomatic tool available here: http://www.usadellab.org/cms/index.php?page=trimmomatic
for file in data/raw_data/*.fastq
do
	TrimmomaticSE -threads 222 -phred33 $file data/trimmed/$(basename -s .fastq $file).trim.fastq LEADING:5 TRAILING:5 SLIDINGWINDOW:8:25 MINLEN:150
done

for file in data/trimmed/*.trim.fastq
do
	bioawk -c fastx '{print ">"$name"\n"$seq}' $file > data/trimmed/$(basename -s .fastq $file).fasta
done
