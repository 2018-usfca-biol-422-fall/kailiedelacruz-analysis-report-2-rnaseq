line=0
while read -r field1 field2; do
	echo Processing $line of 228691
	line=$((line+1))
	echo "$(grep "$field1" output/sailfish_quants/ERR164474/quant.sf | cut -f1) $field2" >> transcript_to_gene_lookup.txt &
done < $1
