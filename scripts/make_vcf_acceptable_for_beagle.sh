INPUT=$1
OUTPUT=$2
BCFTOOLS=$3

##    GT:AD:DP:GQ:PL  0/0:1,0:1:3:0,3,35
${BCFTOOLS} view -h ${INPUT} > ${OUTPUT}
${BCFTOOLS} view -H ${INPUT} | awk 'BEGIN{OFS="\t"} {if($9 != "GT:AD:DP:GQ:PL") {$9="GT:AD:DP:GQ:PL"; $10="./.:0,0:0:0:0,0,0"; print $0} else {print $0}}' - >> ${OUTPUT}
