#!/bin/bash
#cycle through kmer and coverage values to get the best assembly
ABYSSPE=../app/abyss-pe
FQT1=100489_R1.fq-trimmed-pair1.fastq
FQT2=100489_R1.fq-trimmed-pair2.fastq
for k in 31 41 51 61 ; do
  for c in 3 4 5 ; do
    PFX=k${k}_c${c}
    mkdir $PFX
    if [ ! -r $PFX/finished ] ; then
      $ABYSSPE -c $PFX k=$k c=$c e=$c b=0 j=$nproc in="$FQT1 $FQT2" && touch $PFX/finished
    fi
  done
done
