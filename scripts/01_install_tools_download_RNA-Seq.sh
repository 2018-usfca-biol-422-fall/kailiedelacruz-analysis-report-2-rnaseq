# Script to install necessary tools and download sequencing files
# for RNA-Seq analysis

# Naupaka Zimmerman
# November 1, 2017
# naupaka@gmail.com

# download newest sra-toolkit
wget --output-document sratoolkit.tar.gz http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/current/sratoolkit.current-ubuntu64.tar.gz

# untar it
tar -vxzf sratoolkit.tar.gz

# add it to PATH
export PATH=$PATH:~/fastq-downloads/sratoolkit.2.8.2-1-ubuntu64/bin/

# download aspera for fast download
 wget http://download.asperasoft.com/download/sw/ascp-client/3.5.4/ascp-install-3.5.4.102989-linux-64.sh

# install it
sudo bash ascp-install-3.5.4.102989-linux-64.sh

# run this from NCBI to configure download directory
vdb-config.2.8.2-1

# this converts .sra files to .fastq files, e.g.
fastq-dump.2.8.2 -O data/raw_data data/raw_data/sra/ERR164596.sra

# excise column of sample run ids for downloading
cut -f 10 data/metadata/ERP001058_SraRunTable.txt > accessions_to_download.txt

# download these using aspera ascp from the file list
prefetch.2.8.2 -t ascp -a "/usr/local/bin/ascp|/mnt/raid/class_data/2017-03-Fall/downloading_li2015/asperaweb_id_dsa.openssh" -p 0.5 --option-file accessions_to_download.txt


