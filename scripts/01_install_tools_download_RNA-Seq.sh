#!/bin/bash

# Script to install necessary tools and download sequencing files
# for RNA-Seq analysis - assumes Ubuntu 16.04

# Naupaka Zimmerman
# November 1, 2017
# nzimmerman@usfca.edu

# for futher information on much of the below, see:
# https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc
# https://www.biostars.org/p/111040/
# http://genomespot.blogspot.com/2015/01/sra-toolkit-tips-and-workarounds.html

# download newest precompiled sra-toolkit binary from NCBI
wget --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz

# untar and unzip it
tar -vxzf sratoolkit.tar.gz

# add toolkit programs to PATH
export PATH=$PATH:~/fastq-downloads/sratoolkit.2.8.2-1-ubuntu64/bin/

# download aspera for fast download of files from ncbi
wget http://download.asperasoft.com/download/sw/ascp-client/3.5.4/ascp-install-3.5.4.102989-linux-64.sh

# install it (requires sudo privilages)
sudo bash ascp-install-3.5.4.102989-linux-64.sh

# run this program from NCBI to configure download directory
# must do manually
vdb-config.2.8.2-1

# excise column of sample run ids for downloading
cut -f 10 data/metadata/ERP001058_SraRunTable.txt > data/metadata/accessions_to_download.txt

# download target sra files from the file list using aspera ascp
# documentation here:
# https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc&f=prefetch
prefetch.2.8.2 -t \
  ascp -a "/usr/local/bin/ascp|/mnt/raid/class_data/2017-03-Fall/downloading_li2015/misc/asperaweb_id_dsa.openssh" \
  -p 0.5 \
  --option-file data/metadata/accessions_to_download.txt
