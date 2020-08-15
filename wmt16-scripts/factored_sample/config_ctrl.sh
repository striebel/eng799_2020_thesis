#!/bin/sh

# Path to nematus
nematus=../../nematus

# CUDA device id
device=0
  
CUDA_VISIBLE_DEVICES=$device python $nematus/nematus/train.py `# validerr = train(                        ` \
  --model 'model/ctrl/model_ctrl.npz'                         `# saveto='model/ctrl/model_ctrl.npz',      ` \
  --reload latest_checkpoint                                  `# reload=True,                             ` \
  --dim_word 500                                              `# dim_word=500,                            ` \
  --factors 3                                                 `# factors=3,                               ` \
  --dim_per_factor 370 5 125                                  `# dim_per_factor=[370,5,125],              ` \
  --state_size 1024                                           `# dim=1024,                                ` \
  --target_vocab_size 90000                                   `# n_words=90000,                           ` \
  --source_vocab_sizes 85000 6 1500000                        `# n_words_src=90000,                       ` \
  --decay_c 0.0                                               `# decay_c=0.,                              ` \
  --clip_c 1.0                                                `# clip_c=1.,                               ` \
  --learning_rate 0.0001                                      `# lrate=0.0001,                            ` \
  --optimizer 'adadelta'                                      `# optimizer='adadelta',                    ` \
  --maxlen 50                                                 `# maxlen=50,                               ` \
  --batch_size 80                                             `# batch_size=80,                           ` \
  --valid_batch_size 80                                       `# valid_batch_size=80,                     ` \
  --source_dataset 'data/corpus.factors_ctrl.de'              `# datasets=['data/corpus.factors_ctrl.de', ` \
  --target_dataset 'data/corpus.bpe.en'                       `#   'data/corpus.bpe.en'],                 ` \
  --valid_source_dataset 'data/newstest2013.factors_ctrl.de'  `# valid_datasets=['data/newstest2013....', ` \
  --valid_target_dataset 'data/newstest2013.bpe.en'           `#   'data/newstest2013.bpe.en'],           ` \
  --dictionaries 'data/corpus.bpe.de.json' `# bpe segments     # dictionaries=['data/corpus.bpe.de.json', ` \
    'data/corpus.factors.1.de.json'        `# bpe labels       #   'data/corpus.factors.1.de.json',       ` \
    'data/corpus.factors.2.de.json'        `# lemmas           #   'dada/corpus.factors.2.de.json',       ` \
    'data/corpus.factors.3.de.json'        `# ud pos tags      #   'data/corpus.factors.3.de.json',       ` \
    'data/corpus.factors.4.de.json'        `# stts pos tags    #   'data/corpus.factors.4.de.json',       ` \
    'data/corpus.bpe.en.json'              `# bpe segments     #   'data/corpus.bpe.en.json']             ` \
  --valid_freq 10000                                          `# validFreq=10000,                         ` \
  --disp_freq 1000                                            `# dispFreq=1000,                           ` \
  --save_freq 30000                                           `# saveFreq=30000,                          ` \
  --sample_freq 10000                                         `# sampleFreq=10000,                        ` \
                                           `# default: false   # use_dropout=False,                       ` \
  --rnn_dropout_embedding 0.2              `# input dropout    # dropout_embedding=0.2,                   ` \
  --rnn_dropout_hidden 0.2                 `# hidden dropout   # dropout_hidden=0.2,                      ` \
  --rnn_dropout_source 0.1                 `# source dropout   # dropout_source=0.1,                      ` \
  --rnn_dropout_target 0.1                 `# target dropout   # dropout_target=0.1,                      ` \
                                           `# default: ?       # overwrite=False,                         ` \
  --valid_script 'validate.sh ctrl'                           `# external_validation_script='valid.....') `
