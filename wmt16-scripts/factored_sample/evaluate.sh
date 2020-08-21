#!/bin/sh

#                      model for eval     test data set
# usage: ./evaluate.sh <{ctrl,udts,stts}> <{2015,2016}>

device=0
this_dir=`dirname $0`
nematus=$this_dir/../../nematus
model="${this_dir}/model/${1}/model_${1}.npz.best_valid_script"
test="${this_dir}/data/newstest${2}.factors_${1}.de"
candidate_bpe="${this_dir}/eval/${1}/newstest${2}.bpe.en.candidate"
candidate_mrg="${this_dir}/eval/${1}/newstest${2}.en.candidate"
ref_bpe="${this_dir}/data/newstest${2}.bpe.en"
ref_mrg="${this_dir}/data/newstest${2}.en"

mkdir $this_dir/eval
mkdir $this_dir/eval/$1

CUDA_VISIBLE_DEVICES=$device python $nematus/nematus/translate.py \
     -m $model \
     -i $test \
     -o $candidate_bpe \
     -k 12 \
     -n

# merge bpe segments, detruecase, and detokenize
$this_dir/postprocess-test.sh < $candidate_bpe > $candidate_mrg
$this_dir/postprocess-test.sh < $ref_bpe > $ref_mrg

# evaluate with detokenized BLEU (same as mteval-v13a.pl)
$nematus/data/multi-bleu-detok.perl $ref_mrg < $candidate_mrg | tee "${candidate_mrg}.score"
