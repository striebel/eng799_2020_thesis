# theano device, in case you do not want to compute on gpu, change it to cpu
#device=gpu
device=cuda

THEANO_FLAGS=mode=FAST_RUN,floatX=float32,device=$device,on_unused_input=warn python config_${1}.py
