import numpy
import os
import sys
import logging

VOCAB_SIZE = 90000
SRC = "de"
TGT = "en"
DATA_DIR = "data/"

from nematus.nmt import train

logging.basicConfig(level=logging.INFO, format='%(levelname)s: %(message)s')

if __name__ == '__main__':
    validerr = train(saveto='model/stts/model_stts.npz',
                    reload_=True,
                    dim_word=500,
                    factors=4,
                    dim_per_factor=[360,5,115,20],
                    dim=1024,
                    n_words=VOCAB_SIZE,
                    n_words_src=VOCAB_SIZE,
                    decay_c=0.,
                    clip_c=1.,
                    lrate=0.0001,
                    optimizer='adadelta',
                    maxlen=50,
                    batch_size=80,
                    valid_batch_size=80,
                    datasets=[DATA_DIR + '/corpus.factors_stts.' + SRC, DATA_DIR + '/corpus.bpe.' + TGT],
                    valid_datasets=[DATA_DIR + '/newstest2013.factors_stts.' + SRC, DATA_DIR + '/newstest2013.bpe.' + TGT],
                    dictionaries=[DATA_DIR + '/corpus.bpe.' + SRC + '.json',        # bpe segments
                                  DATA_DIR + '/corpus.factors.1.' + SRC + '.json',  # bpe labels
                                  DATA_DIR + '/corpus.factors.2.' + SRC + '.json',  # lemmas
                                  #DATA_DIR + '/corpus.factors.3.' + SRC + '.json', # ud pos tags
                                  DATA_DIR + '/corpus.factors.4.' + SRC + '.json',  # stts pos tags
                                  DATA_DIR + '/corpus.bpe.' + TGT + '.json'],       # bpe segments
                    validFreq=10000,
                    dispFreq=1000,
                    saveFreq=30000,
                    sampleFreq=10000,
                    use_dropout=False,
                    dropout_embedding=0.2, # dropout for input embeddings (0: no dropout)
                    dropout_hidden=0.2, # dropout for hidden layers (0: no dropout)
                    dropout_source=0.1, # dropout source words (0: no dropout)
                    dropout_target=0.1, # dropout target words (0: no dropout)
                    overwrite=False,
                    external_validation_script='validate.sh stts')
    print validerr
