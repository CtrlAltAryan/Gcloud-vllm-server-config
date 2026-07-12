<p align="center">
  <a href="" rel="noopener">
    <img
      src="/home/suki/PROJECTS/Gcloud-doc/Gcloud-vllm-server-config/Images/Gcloud.png"
      alt="Project logo"
      width="200"
      height="200"
      style="border-radius: 50%; object-fit: cover;"
    >
  </a>
</p>

</p>

<h3 align="center">Gcloud vLLM Server Config</h3>

<div align="center">

[![Platform](https://img.shields.io/badge/platform-Google%20Cloud-blue)]()
[![Docker](https://img.shields.io/badge/Docker-Ready-2496ED?logo=docker&logoColor=white)]()
[![vLLM](https://img.shields.io/badge/vLLM-Inference-orange)]()
[![GitHub Issues](https://img.shields.io/github/issues/CtrlAltAryan/Gcloud-vllm-server-config)](https://github.com/CtrlAltAryan/Gcloud-vllm-server-config/issues)
![GitHub Pull Requests](https://img.shields.io/github/issues-pr/CtrlAltAryan/Gcloud-vllm-server-config)
</div>

---

<p align="center"> Deploy and manage an OpenAI-compatible LLM inference server on Google Cloud using Docker and vLLM 
</br>If you found this project helpful, consider giving it a ⭐ on GitHub.
</p>

---

## 📑 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Quick Start](#quick-start)
- [Installation](#installation)
- [Supported Models](#supported-models)
- [Project Scripts](#project-scripts)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [License](#license)

##  Overview <a name = "overview"></a>



**Gcloud vLLM Server Configuration** provides a simple and reproducible setup for deploying open-weight Large Language Models (LLMs) on a Google Cloud GPU instance using **vLLM** and **Docker**.

The server exposes an **OpenAI-compatible API**, allowing existing applications, SDKs, and AI frameworks to interact with self-hosted models with minimal or no code changes. The project is designed to serve as a lightweight inference backend for applications such as Retrieval-Augmented Generation (RAG), AI assistants, chatbots, and other LLM-powered systems.

Rather than focusing on model training or application development, this repository focuses on the infrastructure required to deploy, manage, and serve language models efficiently in the cloud.

## Key Highlights

- Deploy LLMs on Google Cloud with GPU acceleration.
- Serve models through an OpenAI-compatible REST API.
- Use Docker for reproducible and isolated deployments.
- Load models directly from Hugging Face.
- Optimized inference using vLLM.
- Simple management through deployment scripts.

## Features <a name = "#features"></a>

- **Google Cloud Deployment**
  - Deploy open-weight LLMs on a Google Cloud Compute Engine GPU instance.

- **OpenAI-Compatible API**
  - Exposes standard OpenAI endpoints (`/v1/models`, `/v1/chat/completions`) for seamless integration with existing applications and SDKs.

- **Dockerized Deployment**
  - Runs the inference server inside Docker for reproducible and isolated deployments.

- **High-Performance Inference**
  - Powered by **vLLM** for optimized GPU utilization, efficient KV caching, and fast inference.

- **Hugging Face Integration**
  - Download and serve models directly from Hugging Face.

- **GPU Acceleration**
  - Supports NVIDIA GPUs with CUDA acceleration (tested on NVIDIA L4).

- **Simple Server Management**
  - Includes utility scripts to start, stop, and manage the inference server.

- **Remote Administration**
  - Easily manage the server through SSH from a local development machine.

- **Ready for AI Applications**, Can be used as a backend inference server for:
    - Retrieval-Augmented Generation (RAG)
    - Custom LLM-powered applications
    - pretty much any project that needs LLMs

## Project structure <a name = "#project-structure"></a>



```text
Gcloud-vllm-server-config/
├── bin/                    # Utility scripts for server management
│   ├── start.sh
│   ├── stop.sh
│   ├── restart.sh
│   ├── status.sh
│   └── logs.sh
│
├── docker/                 # Docker deployment configuration
│   └── docker-compose.yml
│
├── docs/                   # Project documentation
│   ├── setup.md
│   ├── api.md
│   ├── troubleshooting.md
│   ├── architecture.md
│   └── benchmarks.md
│
├── examples/               # Example API clients and usage
│   ├── python_client.py
│   ├── langchain_client.py
│   ├── rag_client.py
│   └── curl_examples.sh
│
├── cache/                  # Hugging Face model cache (ignored by Git)
├── logs/                   # Runtime logs (ignored by Git)
├── models/                 # Optional local model storage (ignored by Git)
│
├── .gitignore              # Git ignore rules
├── LICENSE                 # Project license
└── README.md               # Project documentation
```

# Prerequisites <a name = "prerequisites"></a>

Before deploying the server, ensure you have the following

## Gcloud Hardware requirments

- NVIDIA GPU (tested on **NVIDIA L4**)
- At least **16 GB GPU VRAM** (depending on the model)
- Sufficient disk space for model downloads (recommended: **100 GB**)

## Operating System

- Ubuntu 22.04 LTS (recommended)

## Cloud Platform

- Google Cloud Platform (GCP)
- Compute Engine enabled
- Billing enabled
- GPU quota available for the selected region

## Software

- Docker
- NVIDIA GPU Driver
- NVIDIA Container Toolkit
- Git
- SSH Client

## Accounts

- Google Cloud account
- Hugging Face account

## Access Requirements

- SSH access to the VM
- Hugging Face Access Token (`HF_TOKEN`)
- Internet connection for downloading models

## Recommended Knowledge

Although not required, familiarity with the following will make deployment easier:

- Basic Linux commands
- Docker fundamentals
- SSH
- Command-line interface (CLI)


# Quick Start <a name = "quickstart"></a>

Follow these steps to deploy an OpenAI-compatible LLM server on a Google Cloud GPU instance.

### 1. Clone the repository

```bash
git clone https://github.com/CtrlAltAryan/Gcloud-vllm-server-config.git
cd Gcloud-vllm-server-config
```

### 2. Export your Hugging Face access token

```bash
export HF_TOKEN="YOUR_HUGGING_FACE_TOKEN"
```

> **Note:** The selected model must be available to your Hugging Face account.

### 3. Start the server

```bash
./bin/start.sh
```

### 4. Verify the server is running

```bash
curl http://localhost:8000/v1/models
```

Expected response:

```json
{
  "object": "list",
  "data": [
    {
      "id": "Qwen/Qwen3-8B"
    }
  ]
}
```

### 5. Send your first request

```bash
curl http://localhost:8000/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{
  "model": "Qwen/Qwen3-8B",
  "messages": [
    {
      "role": "user",
      "content": "Hello!"
    }
  ]
}'
```

If everything is configured correctly, the server will return a chat completion response.


# Installation

Detailed installation instructions are available in the dedicated guide.

 **[View Installation Guide](docs/installation.md)**



# Supported Models <a name = "#supported-models"></a>

The deployment is designed to work with models supported by **vLLM** and available through **Hugging Face**.

## Tested Models

The following models have been tested with this repository:

| Model | Status |
|-------|--------|
| Qwen/Qwen3-8B | ✅ Tested |

---

## Compatible Models

This deployment can be adapted to run many other vLLM-compatible models, including:

| Model Family | Example Models |
|--------------|----------------|
| Qwen | Qwen2.5, Qwen3 |
| Gemma | Gemma 2, Gemma 3* |
| Llama | Llama 3, Llama 3.1 |
| Mistral | Mistral 7B, Mixtral |
| DeepSeek | DeepSeek-R1 Distill models |
| Phi | Phi-3, Phi-4 |

> **Note:** Some models may require additional GPU memory, Hugging Face access approval, or changes to the deployment configuration.

---

## Changing the Model

To deploy a different model, edit the model name in:

```text
docker/docker-compose.yml
```

or

```text
bin/start.sh
```

Replace:

```text
Qwen/Qwen3-8B
```

with the desired Hugging Face model identifier.

Example:

```text
meta-llama/Llama-3.1-8B-Instruct
```

or

```text
google/gemma-3-12b-it
```

> Ensure your selected model is supported by vLLM and that your GPU has sufficient VRAM.


# Project Scripts

The `bin/` directory contains utility scripts for managing the vLLM server deployment.

| Script | Description | Status |
|--------|-------------|:------:|
| `start.sh` | Starts the Docker container and launches the configured LLM server. | ✅ Available |
| `stop.sh` | Stops the running Docker container and removes it. | ✅ Available |
| `restart.sh` | Restarts the LLM server by stopping the current container and starting a new one. | 🚧 Planned |
| `status.sh` | Displays the current status of the server and related services. | 🚧 Planned |
| `logs.sh` | Displays the server logs for monitoring and debugging. | 🚧 Planned |

## Running a Script

From the project root directory, execute any script using:

```bash
./bin/<script-name>.sh
```

### Examples

```bash
./bin/start.sh
./bin/stop.sh
./bin/restart.sh
./bin/status.sh
./bin/logs.sh
```

# Roadmap
> **This project is open to community contributions.** If you'd like to improve an existing feature or propose a new one, feel free to open an issue or submit a pull request.

| Feature | Status |
|---------|:------:|
| Implement `restart.sh` |  Planned |
| Implement `status.sh` |  Planned |
| Implement `logs.sh` |  Planned |
| Support multiple vLLM compatible models |  Planned |
| Add configurable deployment through `.env` |  Planned |
| Add health check script |  Planned |
| Add automatic model download verification |  Planned |
| Add deployment guide for new users |  Planned |
| Add Python client examples |  Planned |
| Add LangChain integration example |  Planned |
| Improve project documentation |  Planned |
| Add deployment for additional cloud providers (AWS/Azure) |  Future |

# Contributing

Contributions are always welcome!

feel free to open an issue or submit a pull request!
Whether you'd like to:
- Fix bugs
- Improve documentation
- Add support or feature from Roadmap section
- Improve examples
- Suggest new features





## ✍️ Authors <a name = "authors"></a>

- [@CtrlAltAryan](https://github.com/CtrlAltAryan) - Idea & Initial work

See also the list of [contributors](https://github.com/CtrlAltAryan/Gcloud-vllm-server-config/graphs/contributors) who participated in this project.



# License

This project is licensed under the **MIT License**.

See the [LICENSE](LICENSE) file for more information.