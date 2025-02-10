docker buildx build -t espnet-text-to-speech-neuron:latest -f Dockerfile.neuron .
docker run -t -d \
    -v /home/ubuntu/efs/git/espnet-text-to-speech-xla:/app \
    -v /tmp:/cache \
    --shm-size=16g \
    --net=host \
    --device=/dev/neuron0 \
    docker.io/library/espnet-text-to-speech-neuron:latest  sleep infinity