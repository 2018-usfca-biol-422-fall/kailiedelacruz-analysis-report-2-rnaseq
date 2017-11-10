cat small_sample.gff | perl -ane '$F[7]=~/Genbank:(\w+).*?gene=(\w+)/; print "$F[0]\t$F[3]\t$F[4]\t$F[6]\t$1\t$2\n";' | head -30

cut -f1 output/sailfish_quants/ERR164619/quant.sf | sed 's/_/\t/g' | head -10 | column

head -100 output/sailfish_quants/ERR164619/quant.sf

# need to construct a transcript to gene ID mapping table
# first, construct non-redundant list of Genbank ID to Gene names
# second, grep over first column in quant.sf files to find Genbank ID and then add
# Gene name as second column, this gets loaded into R

cat _ncbi_downloads/annotation/Homo_sapiens_genomic_refseq.gff \
	| perl -ane '$F[8]=~/Genbank:(\w+).*?gene=(\w+)/; print "$1\t$2\n";' \
	| sort | uniq | tail -n +2 > NCBI_GenbankID_to_gene_name.tsv
bash build_trnscpt_gene_table.sh NCBI_GenbankID_to_gene_name.tsv

grep -P "lcl.* \w+" transcript_to_gene_lookup.txt > transcript_to_gene_lookup_2cols.txt
