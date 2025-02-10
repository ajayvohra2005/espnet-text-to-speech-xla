#export OMP_NUM_THREADS=16
export NEURON_CC_FLAGS="--cache_dir=/cache --optlevel=1"
export NEURON_RT_STOCHASTIC_ROUNDING_EN="1"
#export XLA_IR_SHAPE_CACHE_SIZE="20480"
#export XLA_IR_DEBUG=1
#export XLA_HLO_DEBUG=1
#export PT_XLA_DEBUG=1
#export PT_XLA_DEBUG_FILE=./pt_xla_debug.txt
python tts_xla_hello_world.py
