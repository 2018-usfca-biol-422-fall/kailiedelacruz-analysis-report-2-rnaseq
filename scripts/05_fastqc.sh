# Run fastqc on all fastq files and save output to output dir, using 86 threads

fastqc data/raw_data/fastq/*.fastq --outdir output/fastqc -t 86
