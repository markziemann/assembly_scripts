#!/bin/bash
set -x
#cycle through kmer and coverage values to get the best assembly
#ABYSSPE=../app/abyss-pe
FQT1=100489_R1.fq-trimmed-pair1.fastq
FQT2=100489_R1.fq-trimmed-pair2.fastq
for k in 31 41 51 61 71 81; do
  for c in 3 5 10 15 20 25; do
    PFX=k${k}_c${c}
    mkdir $PFX
    if [ ! -r $PFX/finished ] ; then
      #abyss-pe -c $PFX k=$k c=$c e=$c b=0 j=$nproc in="$FQT1 $FQT2" && touch $PFX/finished
      abyss-pe -C $PFX name=test k=$k c=$c e=$c b=0 j=16 in="../$FQT1 ../$FQT2" && touch $PFX/finished
    fi
  done
done
