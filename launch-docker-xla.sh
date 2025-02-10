docker buildx build -t espnet-text-to-speech-xla:latest -f Dockerfile.xla .
docker run -t -d \
    -v /home/ubuntu/efs/git/espnet-text-to-speech-xla:/app \
    -v /tmp:/cache \
    --shm-size=16g \
    --net=host \
    --gpus=all \
    docker.io/library/espnet-text-to-speech-xla:latest  sleep infinity