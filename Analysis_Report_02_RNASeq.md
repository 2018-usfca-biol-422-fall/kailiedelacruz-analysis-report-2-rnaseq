Analysis Report 2: The SPP1 Gene Showing Higher Expression Counts in Lung Cancer Related Traits
================
Kailie Dela Cruz
November 21, 2018

Introduction
============

Lung cancer is the leading cause of death among men and women in the United States (Torre *et al.*, 2016). Worldwide, it is also the leading cause of death among men and the second leading cause of death among women. Lung cancer rates and trends around the world and in the United States vary among different factors such as sex, age, race, socioeconomic status, and geography (Devesa *et al.*, 2005). In the United States specifically, mortality rates in relation to lung cancer are highest among areas in the mid-South, males, black people, and people of lower socioeconomic status. Like any cancer, this can be caused by a number of factors such as genetics, environmental quality, and smoking status.

In many studies that deal with lung cancer in the population, the smoking status of patients is most commonly looked at. In the year of 1954, William Watson and Alexander Conte, in their scientific study of looking at smoking and lung cancer, mentioned how clinical reports that looked at the relationship between tobacco smoking and lung cancer have looked into the fact that it is rare to find a lung cancer in a man who was not previously or currently a heavy smoker (Watson and Conte, 1954). In a more recent study as well, this fact is *still* being looked at. In the year of 2000, about 50 years later, Doll also emphasized how cigarette smoking is a significant factor in the production of carcinoma in the lung, along with all of the other harmful effects that it causes (DOLL, 2000).

Even with all of these factors that contribute to our possibilites of getting lung cancer, there are still lifestyle changes that we can make to help reduce these chances. One of the most straightforward life changes that we can work on making, is what we choose to include in our diets. Observational studies looking at the relationship between diet and lung cancer suggest that an increase in vegetable and fruit intake can reduce the risk in men and women, whether they are smokers, previous smokers, or people who have never smoked before (Ziegler *et al.*, 1996). But if this option, among others, do not work and lung cancer still prevails, there are many forms of treatment that can work to reduce the consequences related to the disease. While some forms of treatment are straightforward, such as quitting smoking and receiving palliative care, there are also more complicated treatments, like taking complex medications and getting surgery (Temel *et al.*, 2010).

Lung cancer rates, causes, reduction recommandations, and treatment can be difficult to pinpoint and understand as there are many factors that come into play. In "RNA-seq analysis of lung adenocarcinomas reveals different gene expression profiles between smoking and nonsmokin patients," Li et al. focuses on exploring the gene expression profile and identifying the similarities and differences in looking at genes in smokers and nonsmokers (Li *et al.*, 2015). In looking at RNA-seq data from paired normal and tumor tissues in both 34 nonsmoking and 34 smoking patients with lung adenocarcinoma, they applied a general linear model to identify genes that were differentially expressed in nonsmoker and smoker patients and genes that varied between the two groups. Through their research, they discovered that gene expression varied at a considerable amount between nonsmoker and smoker patients with lung adenocarcinoma. They also discovered that smoking patients had more complicated disease mechanisms and abnormality with the regualation of metabolic processes. Through transcriptome analysis, their study revealed that there were pathogenetic differences in smoking and nonsmoking patients that had lung adenocarcinoma.

In analyzing the data from Li et al.'s study, we looked at the variability in the expression of different genes. Using the TMPRSS4, SPP1, and MMP1 genes, which are genes that have been shown to be related with poor prognosis, more aggressive phenotype, or early onset of lung cancer, we had the following main question: In looking at a focal gene that has a high expression mean count in cancer tissues, how do the mean expression counts of this gene vary in terms of age at diagnosis, the different stages of cancer, and the smoking status of the patients? In the Li et al. study, RNA-seq data was gathered from 34 nonsmoking patients and 34 smoking patients. Using this data, we trimmed the reads appropriately, ran the Sailfish tool for transcript quantification from RNA-seq data, and we built a transcript gene table. Taking a look at the gathered data, we hypothesized that the focal gene would have higher expression values in higher stages of the lung cancer, in patients that have or are currently smoking, and in older ages of diagnosis. We tested this hypothesis by looking at the mean expression values of the three genes of TMPRSS4, SPP1, and MMP1 in cancer tissue versus normal tissue. Using the highest expressed gene in cancer tissue, we then looked at how the expression values of this gene vary among the different factors of age at diagnosis, cancer stages, and smoking status. Seeing the result of this analysis could ultimately lead to information that can benefit everyone. Specifically, as lung cancer is the leading cause of cancer death in the United States, understanding how genes and their expression patterns work, could give the population a better idea of how to possibly control this in the future. Specifically, if the upregulation of a certain gene is seen in older ages of diagnosis, higher cancer stages, and positive smoking status, then we may be able to understand that this gene may be one of the introductions to lung cancer. Overall, the analysis behind these genes and the data found in the Li et al. study can give us some insight about how to get more information about lung cancer in general.

Methods
=======

Sample origin and sequencing
----------------------------

### RNA Sequencing Data and Phenotype Data

Li et al. downloaded the transcriptome sequencing data from 68 lung adenocarcinoma patients with validated smoking status from Gene Expression Omnibus (GEO) with the accession number GSE40419 (Li *et al.*, 2015). In the 68 patients, both the tumor and paired normal tissue had been sequenced. With 34 patients who had never been smokers and 34 patients who either have smoked or are current smokers, they restricted analysis of the people who either have smoked or are current smokers to patients under 75 in order to ensure comparability in age ranges between both groups. Li et al. downloaded independent RNA-seq data from six patients who have never smoked from GEO with the accession number GSE37765 in order to validate the genes in the nonsmoker group. The age range for these six patients varied from 44 to 70.

### Differential Gene Expression Analysis

Li et al. conducted geneotype calling of single nucleotide variants (SNVs) on 136 RNA-seq bam files from 68 individuals (Li *et al.*, 2015). This was done in order to confirm the paired relationship of RNA-seq data from both normal and tumor tissue. In a 2012 study, Seo et al. used a clustering method in order to recognize differentially expressed genes in both smoker and nonsmoker patients that had lung adenocarcinoma. They discovered genes with varied expression between normal and tumor tissue across their data samples (Seo *et al.*, 2012). Li et al. on the other hand, analyzed differential gene expression using pair-wise comparison between both normal and tumor tissue and nonsmokers and smokers. They calculated pair-wise concordance rates for 9180 pairs total, which includes between individuals and between individual pairs. They found that the there is a paired nature of RNA-seq data from tumor and normal tissue. Using Tophat, Li et al. aligned pair-end RNA-seq reads to human genome assembly Ensembl GRCh37. They used R Bioconductor edgeR to perform the differential expression analysis and applied a general lienar model (lung tissue expression~smoking+smoking:patient+smoking:tissue). This model allowed them to identify genes that were differentially expressed in normal versus tumor tissue in nonsmoker or smoker patients, as well as genes that act differently between smoker and nonsmoker patients. They only kept tags that had at least 1 count per million in at least half of the sample size in the analysis. They noted significant genes as genes with Benjamini-Hochberg adjusted FDF &lt; 0.05 and absolute values of logFC greater than 1.

### Gene Function Annotation and Pathway Analysis

In order to look into the functional roles and relationships of the genes with different expression in the analysis, Li et al. analyzed the pathway. To analyze the pathway, they submitted the logFC value of significant genes to Ingenuity Pathway Analysis (IPA).

Computational
-------------

### Install Tools

Given the data from the Li et al. study, we first downloaded important toolkits from NCBI. Specifically, we downloaded the newest precompiled SRA-toolkit binary, which we then untarred it, unzipped it, and added the toolkit programs to PATH. We downloaded aspera for fast download of files from NCBI, installed it, and ran the program manually to configure download directory. After excising the column of sample run ids, we downloaded the target sra files from the file lise using aspera ascp.

### Download Genome and Convert SRA to Fastq

Using R script, we installed the biomartr package fro mBioconductor and then used it to download a reference genome, transcripts, and annotations for the human genome from NCBI RefSeq. The biomartr package allows for straightforward function for bulk retrieval of the needed genomic data (Drost and Paszkowski, 2017). After downloading the genome from the Li et al. study, we converted the paired-end SRA files to fastq files.

### Build Sailfish Index

Sailfish is a tool that is used for transcript quanitification from RNA-Seq data (Patro *et al.*, 2014). This tool requires a set of target transcripts to quantify. With this requirement fulfilled, sailfish runs in two phases; indexing and quantification. For this analysis though, we installed the Sailfish source with the requirement of boost libraries, and built a Sailfish index by running this script:

sailfish index -t \_ncbi\_downloads/RNA/Homo\_sapiens\_rna\_from\_genomic\_refseq.fna -o output/sailfish-index

### Trimmomatic

After running fastqc on all fastq files and saving the output to the output director, we trimmed the paired end reads in parallel. With the trimmomatics tool and paired end reads, adapters will be removed, leading low quality or N based will be removed, trailing low quality or N based will be removed, reads with a 4-base wide sliding window will be scanned and cut when the average quality per base drops below 15, and reads below 36 bases long will be dropped (Bolger *et al.*, 2014). I ran the trimmoatics tool by running this script:

for file in "$@"; do TrimmomaticPE -threads 8 -basein *f**i**l**e*  − *b**a**s**e**o**u**t**d**a**t**a*/*t**r**i**m**m**e**d*/(basename -s \_1.fastq $file).trim.fastq
ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3
SLIDINGWINDOW:4:20 MINLEN:50 & done

After running this script to trim paired end reads, I checked if the output file for given input already exists. If it didn't, we ran Trimmomatic. This must be done because only so many threads can use Java at once, and so there may be files that are not yet trimmed. Such script was used to do so:

for file in "$@" do  SAMPLE=$(basename -s \_1.fastq $file) if \[ `ls data/trimmed | grep -c $SAMPLE` -eq 0 \] then TrimmomaticPE -threads 8 -basein *f**i**l**e*  − *b**a**s**e**o**u**t**d**a**t**a*/*t**r**i**m**m**e**d*/(basename -s \_1.fastq $file).trim.fastq
ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3
SLIDINGWINDOW:4:20 MINLEN:50 & fi done

### Running Sailfish

In order to count all of the reads from the trimmed reads after both paired reads made it through Trimmomatic QC, we ran Sailfish using this script:

for sample in "$@" do  sampleID=$(basename -s .trim\_1P.fastq $sample) echo "--------------------------------------------------" echo "Processing sample $sampleID"  sailfish quant -i output/sailfish-index/ \\
 -l IU \\
 -1 data/trimmed/$sampleID.trim\_1P.fastq
-2 data/trimmed/*s**a**m**p**l**e**I**D*.*t**r**i**m*<sub>2</sub>*P*.*f**a**s**t**q*  − *o**o**u**t**p**u**t*/*s**a**i**l**f**i**s**h*<sub>*q*</sub>*u**a**n**t**s*/sampleID
-p 88 done

### Parse, Build Transcript Gene Table, and Consolidate Counts

To construct a transcript to gene ID mapping table, we parsed with the following script:

cat \_ncbi\_downloads/annotation/Homo\_sapiens\_genomic\_refseq.gff
| perl -ane '$F\[8\]=~/Genbank:(+).\*?gene=(+)/; print "$1$2";'
| sort | uniq | tail -n +2 &gt; NCBI\_GenbankID\_to\_gene\_name.tsv

We then searched for the Genbank ID in the line of the input and cut out the full transcript ID for that match and adds the gene name after it in order to make our lookup table.

We read in all of the transcript counts made by Sailfish individually on each sample. We combined these counts at the transcript level to the gene level, normalized them in terms of length and read depth, and then built a table with genes in the rows and samples in the columns. We then combined the two other metadata files that were gathered from SRA and the supplementary table from the original manuscript.

Results
=======

We looked at three genes that are a part of the human genome. These three genes are SPP1, MMP1, and TMPRSS4. The data in relation to these three genes were taken from RNA-seq data of 34 nonsmoker patients and 34 smoking/previously smoking patients. Using the data obtained from Gene Expression Omnibus (GEO) with the accession number GSE40419 in the Li et al. study, we built a sailfish index, trimmed the reads, and built a transcript gene table. In making a summary table of the top 15 most highly expressed genes in the data collected, there were 9 genes associated with males and 6 genes associated with females. The most highly expressed gene has a mean\_count of 192985.07, while the least highly expressed gene in the top 15 has a mean\_count of 70990.84. With EEF1A1 being the most highly expressed gene, found in both female and male, other genes that are found in both sexes include SFTPC, SFTPB, SFTPA2, SFTPA1, and RNA28S5 with varying mean\_count values. CD74, EEF1A1, and MIR6723 are genes that are only found in the male samples. In looking at the read counts for the top 15 genes in terms of gender and cancer stage, cancer stage 2B reveals a lot of information about the read counts for what seems to be like all male patients. Cancer stage 3B on the other hand, shows a lot of information about the read counts for what seems to be like all female patients. The other cancer stages (1A, 1B, 2A, 3A, 4, and NA) show information about the read counts for both genders.

Mean Expression Counts of SPP1, MMP1, and TMPRSS4 in Cancer Tissue vs Normal Tissue
-----------------------------------------------------------------------------------

In looking at the overall data collected from the Li et al. study, we first analyzed the mean expression counts of MMP1, SPP1, and TMPRSS4 in cancer tissues and normal tissues \[Figure 3\]. These three genes were used because they were said to be related to poor prognosis, aggressive phenotype, and early onset of lung cancer in the Li et al. study. While SPP1 and MMP1 both have higher mean expression count in cancer tissues compared normal tissues, TMPRSS4 has a mean expression value in cancer tissues and barely any expression value in normal tissues. Specifically, SPP1 has the largest mean expression count in cancer tissues overall with a value of ~8400, while this gene only has a mean expression count in normal tissues with a value of ~100-200. MMP1 reveals a mean expression count of ~2200 in cancer tissues and ~&gt;100 in normal tissues. TMPRSS4 has a mean expression count for cancer tissues at a value of ~400-500, while the value for the mean expression count of this gene in normal tissue is not significant.

Mean Expression Counts of SPP1 in the Different Cancer Stages
-------------------------------------------------------------

Wanting to look further into detail about the expression values of a gene related to lung cancer in terms of different characteristics of the patients, we analyzed SPP1 further. We decided to use SPP1 as the focal gene for further analysis due to the fact that it had the highest mean expression count in cancer tissues in relation to MMP1 and TMPRSS4.

The first characteristic that we decided to look at were the different cancer stages. In looking at the mean expression counts of SPP1 in the different cancer stages (1A, 1B, 2A, 2B, 3A, 3B, 4, and NA) of lung cancer, it was seen that 3A has the largest mean expression count with a value of ~7500. The 1B cancer stage was a close second, with a mean expression count value of ~6750. On the other hand though, the NA stage has the lowest mean expression count value of about 1100. Every other cancer stage (1A, 2A, 2B, 3B, and 4) have varying mean expression count values in between, ranging from ~1750-5500.

Mean Expression Counts of SPP1 in Different Smoking Statuses
------------------------------------------------------------

The second characteristic that we analyzed in terms of SPP1 was smoking status. In looking at the mean expression counts of SPP1 in patients who were previous smokers, current smokers, nonsmokers, and NA, the highest mean expression counts were seen in patients who were either previous or current smokers. For previous smokers, the mean expression count was ~6100, which is only slightly larger than ~5750, which is the mean expression count for current smokers. Patients with unknown smoking status had lowest mean expression count values at about 2500, and patients who had never smoked had a mean expession count value in between at about 4100.

Mean Expression Counts of SPP1 in the Different Ages of Diagnosis
-----------------------------------------------------------------

The last characteristic that we looked at was the age of each patient when they were diagnosed with lung cancer. In looking at the mean expression counts of SPP1 in patients at different ages of diagnosis, the marjority of the expression values are in patients that are 55 years old-78 years old. The highest expression count is found in the 70 year old samples with a value of ~21000, while ~77, ~85, and ~62 year olds have expression counts that are not much lower ranging from ~12000-18000. The samples around the 40 year old range have the lowest mean expression counts ranging from ~500-2100. All other ages have varying mean expression counts in between.

| gender | genename |  mean\_count|
|:-------|:---------|------------:|
| male   | EEF1A1   |    192985.07|
| female | EEF1A1   |    180576.95|
| female | SFTPB    |    145106.22|
| male   | SFTPA2   |    139706.77|
| male   | SFTPB    |    131689.14|
| female | SFTPA2   |    129754.12|
| female | SFTPC    |    121279.39|
| male   | SFTPC    |    112060.50|
| female | SFTPA1   |    103648.69|
| male   | SFTPA1   |    100325.53|
| male   | FTL      |     86060.02|
| male   | RNA28S5  |     75812.40|
| female | RNA28S5  |     75363.40|
| male   | MIR6723  |     73176.55|
| male   | CD74     |     70990.84|

**Table 1**: The most highly expressed genes in both genders included *SFTPB* and *EEF1A1*. While there are 9 males who are found in the top 15 most highly expressed genes, there are 6 females. The most highly expressed gene has a mean\_count of 192985.07, while the least highly expressed gene in the top 15 has a mean\_count of 70990.84.

![](Analysis_Report_02_RNASeq_files/figure-markdown_github/make-barplot-of-highly-expressed-genes-1.png)

**Figure 1**: Here we show the mean\_count of the top 15 most highly expressed genes of both females and males. With EEF1A1 being the most highly expressed gene, found in both female and male, other genes that are found in both sexes include SFTPC, SFTPB, SFTPA2, SFTPA1, and RNA28S5 with varying mean\_count values. CD74, EEF1A1, and MIR6723 are genes that are only found in the male samples.

![](Analysis_Report_02_RNASeq_files/figure-markdown_github/make-boxplot-of-highly-expressed-genes-1.png)

**Figure 2**: Here we show the read counts per gene by gender and cancer stage. Cancer stage 2B reveals a lot of information about the read counts for what seems to be like all male patients. Cancer stage 3B on the other hand, shows a lot of information about the read counts for what seems to be like all female patients. The other cancer stages (1A, 1B, 2A, 3A, 4, and NA) show information about the read counts for both genders

![](Analysis_Report_02_RNASeq_files/figure-markdown_github/make-barplot-of-genes-with-normal-vs-cancer-1.png)

**Figure 3**: Here we show the mean expression counts of the three genes MMP1, SPP1, and TMPRSS4 in cancer vs. normal tissues. These genes were used because they deal with poor prognosis, agressive phenotype, and early onset of lung cancer. While SPP1 and MMP1 both have higher mean expression count in cancer tissues compared normal tissues, TMPRSS4 has a mean expression value in cancer tissues and barely any expression value in normal tissue. SPP1 has the largest mean expression count in cancer tissues overall.

![](Analysis_Report_02_RNASeq_files/figure-markdown_github/make-barplot-of-SPP1-with-cancer-stages-1.png)

**Figure 4**: Looking at SPP1 mean expression counts in the different cancer stages (1A, 1B, 2A, 2B, 3A, 3B, 4, and NA) of lung cancer, it can be seen that 3A has the largest mean expression count with a value of ~7500 with 1B being a close second with a mean expression count value of ~6750. The NA stage has the lowest mean expression count value and every other cancer stage (1A, 2A, 2B, 3B, and 4) have varying mean expression count values in between, ranging from ~1750-5500.

![](Analysis_Report_02_RNASeq_files/figure-markdown_github/make-barplot-of-SPP1-with-smoking-status-1.png)

**Figure 5**: Looking at SPP1 mean expression counts in terms of smoking status, highest mean expression count values were observed in patients who were previous or current smokers ranging from ~5750-6100. Patients with unknown smoking status had lowest mean expression count values at about 2500, and patients who had never smoked had a mean expession count value in between at about 4100.

![](Analysis_Report_02_RNASeq_files/figure-markdown_github/make-barplot-of-SPP1-with-age-1.png)

**Figure 6**: Here we look at mean expression counts of SPP1 in the different ages of diagnosis. With ages ranging from <sub>40-</sub>85, the marjority of the expression values are in patients that are 55 years old-78 years old. The highest expression count is found in the 70 year old samples, while ~77, ~85, and ~62 year olds have expression counts that are not much lower. The samples around the 40 year old range have the lowest mean expression counts.

Discussion
==========

In this analysis, we looked at the data in terms of the variation in expression value of the SPP1 gene with different characteristics related to lung cancer patients. The SPP1 gene was looked at due to the fact that it had the highest expression value in cancer tissues in comparison to the two other genes MMP1 and TMPRSS4. In terms of the data collected in the Li et al. study, our primary question asked how the focal gene's mean expression counts vary throughout different characteristics related to lung cancer. The characteristics that we looked at for this analysis were the different cancer stages, the smoking status of the patients, and the age at which each patient was diagnosed. With this central question, we hypothesized that higher expression values of the focal gene, or SPP1 would be seen in characteristics that relate to aggressive lung cancer. Specifically, we expected to see higher expression values in late cancer stages (3A, 3B, 4, etc.), in patients who were current or previous smokers, and in patients who were diagnosed at an older age compared to the others. In order to test this hypothesis, we first looked for a focal gene. To do this, we gathered the three genes that were related to lung cancer in some way, SPP1, MMP1, and TMPRSS4, as mentioned in the Li et al. study. With these three genes, we looked at the mean expression counts of each of them in both cancer and tumor tissue. Using the gene with the highest expression count in cancer tissue, we analyzed the variation in mean expression counts of this gene in different cancer stages, smoking status, and age at diagnosis.

Figure Analysis
---------------

In order to find my focal gene, we first took a closer look at SPP1, MMP1, and TMPRSS4 mean expression counts in both cancer and normal tissue. In analyzing these three genes, they all represented notable expression values in cancer tissue, but not as significant values in normal tissue. This result could be due to the fact that these genes *are* in fact related to lung cancer. In observing the fact that SPP1 had the highest expression count in cancer tissue in comparison to the other two genes, we were led to the idea that this was my focal gene that would be looked at in terms of the characteristics that we were interested in \[Figure 3\]. With this information, we then looked at the mean expression counts of SPP1 in the different stages of cancer. These results revealed higher expression counts in 1B, 2A, 2B, and especially 3A. While the other stages *did* have notable values of expression, the values that correspond to these cancer stages were more significant. This information stood out to me because the high expression counts are found in the relatively lower cancer stages. Specifically, stages 3B and 4 do not have expression counts as high as the others, which are generally the stages where cancer can no longer be cured. With this confusion that we encountered, we then looked at the mean expression counts of SPP1 in terms of smoking status. The results of this analysis revealed that higher expression values were seen in patients who were either current or previous smokers. On the other hand, patients with the "never" smoking staus had a notably lower expression value, and patients with the "unknown" smoking status had the lowest. As smoking is generally seen as a significant factor with lung cancer, it is not surprising to me that there are higher expression counts of SPP1, a gene related to lung cancer, in patients who have been exposed to smoking. To further analyze the impact of SPP1 on lung cancer, we then analyzed the mean expression counts of such gene in different ages of diagnosis. With patients ranging from <sub>40-</sub>85, the bulk of the expression of SPP1 takes place in ages 50-85. In further detail, highest expression counts were seen generally in ages from 70-85. While there significant expression values among all ages from 40-85, the highest expression counts seen from 70-85 is not surprising. This is because as the human body grows older, the immune system is not as strong and so things like cancer become more possible. As the SPP1 gene is related to cancer, its expression *should* be higher when cancer becomes more inevitable with a weakened immune system at an older age.

With our central question, the analysis results of the data gathered from the Li et al. study generally supported our hypothesis in majority of the aspects, but not all. Specifically, in looking at the expression counts of SPP1 in terms of the different cancer stages, smoking status, and age of the patients at diagnosis, highest expression counts of the gene were found in current or previous smoking patients and at older ages, which is what we had hypothesized. However, in terms of the different cancer stages, the mean expression counts of the SPP1 gene were much varied, with higher expression values towards the earlier stages of lung cancer. With majority acceptance of our hypothesis, we were led to the idea that the SPP1 gene *does* in fact have something to deal with lung cancer. To better understand this though, it is important to know the role of the SPP1 gene in the human body.

With high expression counts of the SPP1 gene in traits that correspond to the idea of lung cancer, it would make sense for this gene to have a close relationship with the disease. In looking into the role of this gene in the human body, it is said that one of the proteins that this gene encodes for is involved in the attachment of osteoclasts to the mineralized bone matrix (Rodrigues, 2009). This protein, osteopontin, is a cytokine with multiple functions that deals with cell proliferation, survival, drug resistance, etc. (Shevde and Samant, 2014). With SPP1 encoding this protein that has to deal with cell proliferation, it makes sense how this gene can have an effect on lung cancer in a negative way. In further detail, higher expression counts of this gene can lead to increased cell proliferation, possibly with no control, which is essentially the same as tumor growth. Seeing higher expression counts of SPP1 in patients with characteristic traits that relate to factors seen commonly in lung cancer (patients who are/were smokers, older ages at diagnosis, etc.) proves the point that the SPP1 gene has an impact on the disease. Other studies have also looked further into this gene and how it has a significant role in the diagnosis of lung cancer. A 2014 study done by Zhang et al. looked at malignant pleural effusion (MPE), which is a common complication of advanced lung cancer and its relationship with the SPP1 gene. They concluded that SPP1 in MPE can be used to determine the prognosis of patients with lung cancer (Zhang *et al.*, 2014). Another study done in 2018 studied different ways to screen differentially expressed genes as biomarkers for prognosis of lung adenocarcinoma. Through their study, they also came to the conclusion that SPP1 is a risk factor for lung adenocarcinoma and may be utilized in the prognosis of patients with the disease (Zhang *et al.*, 2018).

While SPP1 has a negative impact on lung cancer patients, understanding the role of this gene early on can easily have a *positive* impact on patients. The importance behind knowing SPP1's function is that we are one step ahead of a disease that is the leading cause of cancer death among people in the United States and around the world. In further detail, not knowing the genes that are related to deadly diseases such as cancer can ultimately lead to more deaths because we do not know any information relating to it, that might possibly assist us with tackling it. Getting an idea of a specific genes function in a disease can first lead us to initial ideas about how to stop it and possibly lead to its cure in the future. Understanding one genes function in a disease provides encouragement for fighting this disease and understanding other genes that may also be impacting this disease. Knowing the function of this gene in lung cancer is just the beginning though. Proving the idea that a certain gene has an impact on one disease can lead to other researchers doing studies on other genes that impact multiple diseases. Overall, this is one step in preventing detrimental conditions, diseases, etc. that we need to take before tackling more.

Future References
-----------------

In looking at the mean expression counts of the SPP1 gene in terms of different cancer stages, smoking status, and age at diagnosis, further studies can be done to better understand the genes that are associated with lung cancer. Specifically, though the SPP1 gene had an extremely high expression count in cancer tissues in comparison to a group of other genes, those other genes can also be looked at to further back up our hypothesis. As there may be other genes that show high expression counts in characteristics that relate to lung cancer, we would be able to get a better idea of the disease all-in all. Along with looking at other genes, other factors and characteristics that relate to lung cancer can be looked at. In further detail, for this analysis, we looked at the different cancer stages, smoking status, and the age of the patients at diagnosis. Along with this, it may also be helpful to look at other factors, such as the sex of the patients. Gathering more information and seeing more trends and patterns among the patients with lung cancer can generally give us more ideas of how to tackle this disease.

Sources Cited
=============

Bolger,A.M. *et al.* (2014) Trimmomatic: A flexible trimmer for illumina sequence data. *Bioinformatics*, **30**, 2114–2120.

Devesa,S.S. *et al.* (2005) International lung cancer trends by histologic type: Male: Female differences diminishing and adenocarcinoma rates rising. *International journal of cancer*, **117**, 294–299.

DOLL,S.R. (2000) Smoking and lung cancer. *American journal of respiratory and critical care medicine*, **162**, 4–6.

Drost,H.-G. and Paszkowski,J. (2017) Biomartr: Genomic data retrieval with r. *Bioinformatics*, **33**, 1216–1217.

Li,Y. *et al.* (2015) RNA-seq analysis of lung adenocarcinomas reveals different gene expression profiles between smoking and nonsmoking patients. *Tumor Biology*, **36**, 8993–9003.

Patro,R. *et al.* (2014) Sailfish enables alignment-free isoform quantification from rna-seq reads using lightweight algorithms. *Nature biotechnology*, **32**, 462.

Rodrigues,L.R. (2009) SPP1 (secreted phosphoprotein 1).

Seo,J.-S. *et al.* (2012) The transcriptional landscape and mutational profile of lung adenocarcinoma. *Genome research*, **22**, 2109–2119.

Shevde,L.A. and Samant,R.S. (2014) Role of osteopontin in the pathophysiology of cancer. *Matrix Biology*, **37**, 131–141.

Temel,J.S. *et al.* (2010) Early palliative care for patients with metastatic non–small-cell lung cancer. *New England Journal of Medicine*, **363**, 733–742.

Torre,L.A. *et al.* (2016) Lung cancer statistics. In, *Lung cancer and personalized medicine*. Springer, pp. 1–19.

Watson,W.L. and Conte,A.J. (1954) Smoking and lung cancer. *Cancer*, **7**, 245–249.

Zhang,H. *et al.* (2014) Prognostic value of secreted phosphoprotein-1 in pleural effusion associated with non-small cell lung cancer. *BMC cancer*, **14**, 280.

Zhang,W. *et al.* (2018) SPP1 and ager as potential prognostic biomarkers for lung adenocarcinoma. *Oncology letters*, **15**, 7028–7036.

Ziegler,R.G. *et al.* (1996) Nutrition and lung cancer. *Cancer causes & control*, **7**, 157–177.