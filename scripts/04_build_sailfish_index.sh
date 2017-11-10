# create index of kmers for sailfish quasi-aligner

# uses RNA reads from RefSeq database - this is more comprehensive than CDS dataset
sailfish index -t _ncbi_downloads/RNA/Homo_sapiens_rna_from_genomic_refseq.fna -o output/sailfish-index
