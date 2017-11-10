#!/bin/bash

# need to construct a transcript to gene ID mapping table
# first, construct non-redundant list of Genbank ID to Gene names
# second, grep over first column in quant.sf files to find Genbank ID and then add
# Gene name as second column, this gets loaded into R

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 7, 2017

# want to pull out Genbank ID and gene name from the gff annotation file
# and then output this to a text file for later use to consolidate transcript
# counts into gene-level counts and do so with human-readable gene names

# perl approach borrowed from:
# https://www.biostars.org/p/242908/

# `tail -n +2` removes the line with blank space at the beginning of the output
cat _ncbi_downloads/annotation/Homo_sapiens_genomic_refseq.gff \
	| perl -ane '$F[8]=~/Genbank:(\w+).*?gene=(\w+)/; print "$1\t$2\n";' \
	| sort | uniq | tail -n +2 > NCBI_GenbankID_to_gene_name.tsv
