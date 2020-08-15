#!/bin/sh

scp corpus.factors_ctrl.de \
    corpus.factors_udts.de \
    corpus.factors_stts.de \
    corpus.bpe.en \
    newstest2013.factors_ctrl.de \
    newstest2013.factors_udts.de \
    newstest2013.factors_stts.de \
    newstest2013.bpe.en \
    corpus.bpe.de.json \
    corpus.factors.1.de.json \
    corpus.factors.2.de.json \
    corpus.factors.3.de.json \
    corpus.factors.4.de.json \
    corpus.bpe.en.json \
    newstest2013.tok.en \
    usrid@host:/home/usrid/eng799_2020_thesis/wmt16-scripts/factored_sample/data
