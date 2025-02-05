# espnet-text-to-speech-xla

This repository captures exploratory work aimed at determining the viability of 
running [ESPNet](https://github.com/espnet/espnet) text-to-speech (TTS) using 
[Pytorch XLA](https://pytorch.org/xla/release/r2.6/learn/xla-overview.html), 
so that TTS inference
can be run on XLA devices such as AWS Inferentia.

The focus of the work is inference for TTS models that follow the VITS architecture.
The VITS architecture is detailed in the following article: 
[Conditional Variational Autoencoder with Adversarial Learning for
End-to-End Text-to-Speech](https://arxiv.org/pdf/2106.06103).

The specific model that is used for experimentation is `kan-bayashi/ljspeech_vits`. 
This model was selected based on customer input, noting that it produces
good output quality.

At this point first phase of dev/test implementation is complete. 
The TTS architecture and model are working reliably on Pytorch/XLA. 
The audio outputs generated are essentiall identical to the GPU based model execution.

Because of the nature of XLA and tensor graph compilation, inference
for input and/or output tensor shapes that have not been cached will take
several seconds to run. 
Input that correspond to shapes that have been cached, perform with consistent latency.
The work was focused more on capability rather than latency performance. 
That noted, the capability at this point seems to fully match GPU based inference,
the latency is around 3 time slower.

The snapshot used for this experiementation stems from September 2024.
The repo contains all the code from that point in time, plus the updates
to support Pytorch/XLA. Accordingly, you can `pip install` this repo, instead
of the original repo to experiment with the XLA based updates. 
The code changes do not materially impact the running of the ESPNet on GPU.
When/if this work is further refined, it could readily be merged with
ESPNet repository.

Research suggest that may be the first Pytorch/XLA implementation of this architecture.
For rapid testing and exploration of this work, there is a companion repository that
has Docker configuration files and Python test scripts. 
This repository is called 
[espnet-text-to-speech-xla-testing](https://github.com/toby-fotherby/espnet-text-to-speech-xla-testing) 

Hopefully, you find this useful in your R&D.
 
