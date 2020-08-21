#!/bin/sh

# The present directory
this_dir=`dirname $0`

# Path to nematus
nematus=$this_dir/../../nematus

# CUDA device id
device=0
  
CUDA_VISIBLE_DEVICES=$device python $nematus/nematus/train.py  \
  --model 'model/ctrl/model_ctrl.npz'                          \
  --reload latest_checkpoint                                   \
  --dim_word 500                                               \
  --factors 2                                                  \
  --dim_per_factor 493 7                                       \
  --state_size 1024                                            \
  --decay_c 0.0                                                \
  --clip_c 1.0                                                 \
  --learning_rate 0.0001                                       \
  --optimizer 'adam'                                           \
  --maxlen 50                                                  \
  --batch_size 80                                              \
  --valid_batch_size 80                                        \
  --source_dataset 'data/corpus.factors_ctrl.de'               \
  --target_dataset 'data/corpus.bpe.en'                        \
  --valid_source_dataset 'data/newstest2013.factors_ctrl.de'   \
  --valid_target_dataset 'data/newstest2013.bpe.en'            \
  --dictionaries 'data/corpus.bpe.de.json'                     \
    'data/corpus.factors.1.de.json'                            \
    'data/corpus.bpe.en.json'                                  \
  --valid_freq 10000                                           \
  --disp_freq 1000                                             \
  --save_freq 30000                                            \
  --sample_freq 10000                                          \
  --rnn_dropout_embedding 0.2                                  \
  --rnn_dropout_hidden 0.2                                     \
  --rnn_dropout_source 0.1                                     \
  --rnn_dropout_target 0.1                                     \
  --valid_script "$this_dir/validate.sh"
