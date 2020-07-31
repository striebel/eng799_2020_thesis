#!/bin/sh
gunzip -ck corpus.parallel.conll.de.gz > corpus.conll.de
gunzip -ck corpus.parallel.conll.en.gz > corpus.conll.en
gunzip -k newstest2013.conll.de.gz
gunzip -k newstest2013.conll.en.gz
gunzip -k newstest2015.conll.de.gz
gunzip -k newstest2015.conll.en.gz
gunzip -k newstest2016.conll.de.gz
gunzip -k newstest2016.conll.en.gz
