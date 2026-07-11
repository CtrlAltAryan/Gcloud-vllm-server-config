#!/bin/bash

# Remove old container if it exists
docker rm -f qwen3 >/dev/null 2>&1 || true

docker run -d \
  --gpus all \
  --name qwen3 \
  --restart unless-stopped \
  -p 8000:8000 \
  --ipc=host \
  -v ~/.cache/huggingface:/root/.cache/huggingface \
  -e HF_TOKEN="$HF_TOKEN" \
  vllm/vllm-openai:v0.10.1.1 \
  --model Qwen/Qwen3-8B \
  --gpu-memory-utilization 0.90 \
  --max-model-len 8192
