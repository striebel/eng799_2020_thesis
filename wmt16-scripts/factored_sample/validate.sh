#!/bin/sh

translations=$1
this_dir=`dirname $0`
ref=$this_dir/data/newstest2013.tok.en
moses=$this_dir/../../mosesdecoder

# evaluate translations and write BLEU score to standard output
$this_dir/postprocess-dev.sh < $translations | \
    $moses/scripts/generic/multi-bleu.perl $ref | \
    cut -f 3 -d ' ' | \
    cut -f 1 -d ','
