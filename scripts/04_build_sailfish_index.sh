#!/bin/bash

# create index of kmers for sailfish quasi-aligner
# Naupaka Zimmerman
# nzimmerman@usfca.edu
# November 9, 2017

# Documentation is available here
# https://arxiv.org/pdf/1308.3700.pdf
# https://github.com/kingsfordgroup/sailfish
# http://sailfish.readthedocs.io/en/master/building.html#installation
# http://sailfish.readthedocs.io/en/master/sailfish.html
# see also: http://sailfish.readthedocs.io/en/master/library_type.html#fraglibtype

# Installation requires boost libraries:
# http://www.boost.org/doc/libs/1_65_1/more/getting_started/unix-variants.html

# some discussion of best RNA-Seq pipelines (as of ~2015)
# https://www.biostars.org/p/157705/

# uses RNA reads from RefSeq database - this is more comprehensive than CDS dataset
sailfish index -t _ncbi_downloads/RNA/Homo_sapiens_rna_from_genomic_refseq.fna -o output/sailfish-index
