#!/bin/bash

# need to construct a transcript to gene ID mapping table
# first, construct non-redundant list of Genbank ID to Gene names
# second, grep over first column in quant.sf files to find Genbank ID and
# then add Gene name as second column, this will later get loaded into R

# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 7, 2017

# the approach is to go through each line of the input file one at a time,
# and search for the Genbank ID in the line of the input, then cut out the
# full transcript ID for that match and appends the gene name

# NCBI_GenbankID_to_gene_name.tsv (parsed out of gff file)
# has rows that look like this:
## NM_000015       NAT2

# but we want rows that look like this,
# where the first part is the full transcript ID and the second is the gene name
## lcl|NC_000022.11_mrna_NM_000026.3_148863 ADSL

# the rows in the quant files look like:
## Name    Length  EffectiveLength TPM     NumReads
## lcl|NC_000001.11_miscrna_NR_046018.2_1  1652    1466.45 0       0

# they have the transcript ID, but no gene name. So we search for the
# Genbank ID with grep, since that is always a part of the transcript ID,
# then we pull out the transcript name and append the gene name after it to
# make our lookup table

# run with "bash scripts/10_build_trnscpt_gene_table.sh \
#    output/gene_name_lookup_files/NCBI_GenbankID_to_gene_name.tsv"

# initialize counter to track progress in loop
line=0

while read -r field1 field2; do
	echo Processing $line of 228691
	line=$((line+1)) # increment loop counter
	# find full transcript name from sailfish quant output and make that first
	# column of output file, then add a space, then the gene name (was second
	# column in NCBI_GenbankID_to_gene_name.tsv file)
	# We just use sample ERR164474 here arbitrarily - the first column in all
	# of the quant.sf files is the same so it doesn't matter which we pick

	# do this loop in parallel to go faster
	echo "$(grep "$field1" output/sailfish_quants/ERR164474/quant.sf | cut -f1) $field2" >> output/gene_name_lookup_files/transcript_to_gene_lookup.txt &
done < $1

# remove lines that don't have an appropriate trancript ID since these won't
# be useful to us later anyway. `-P` is to use perl regular expressions
grep -P "lcl.* \w+" output/gene_name_lookup_files/transcript_to_gene_lookup.txt > output/gene_name_lookup_files/transcript_to_gene_lookup_2cols.txt
