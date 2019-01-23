#!/bin/bash

# application paths
SKEWER="../app/skewer/skewer"
FASTQC="../app/fastqc"
ABYSSPE="../app/abyss-pe"

k=51
c=5

for FQZ1 in 100489_R1.fq.gz ; do
  FQZ2=$(echo $FQZ1 | sed 's/_R1.fq.gz/_R2.fq.gz/')
  FQT1=$(echo $FQZ1 | sed 's/.fq.gz/.fq-trimmed-pair1.fastq/')
  FQT2=$(echo $FQZ1 | sed 's/.fq.gz/.fq-trimmed-pair2.fastq/')
  PFX=$(echo $FQZ1 | sed 's/_R1.fq.gz/')

  mkdir $PFX
  if [ ! -r $PFX/finished ] ; then
    $FASTQC $FQZ1 $FQZ2 
    $SKEWER -t 16 -q 20 100489_R1.fq.gz 100489_R2.fq.gz
    $ABYSSPE -c $PFX k=$k c=$c e=$c b=0 j=$nproc in="$FQT1 $FQT2" && touch $PFX/finished
  fi
done

