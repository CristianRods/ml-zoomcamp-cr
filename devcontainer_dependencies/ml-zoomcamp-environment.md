
## 🛠️ `Makefile` (Aligned with Your Dockerfile)

```dockerfile

# Makefile for ML Course Docker Setup

# Base image with Python and common ML tools
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Avoid interactive prompts during installs
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Optional: expose Jupyter port
EXPOSE 8888

# Default command (can be overridden by Makefile)
CMD ["bash"]
```

---

## 📘 `README.md` to make all this explainable

```markdown
# 🧠 ML Course Environment (Docker + WSL)

This repository contains a reproducible Docker-based setup for running machine learning scripts and notebooks inside WSL.

## 🚀 Features

- Python 3.10 (via Docker)
- Jupyter Notebook server exposed on port 8888
- Isolated environment for ML experimentation
- Compatible with WSL2 and Docker Desktop

## 📁 Project Structure

```
ml-course/
├── data/               # datasets
├── notebooks/          # Jupyter notebooks
├── scripts/            # Python scripts
├── requirements.txt    # Python dependencies
├── Dockerfile          # container definition
├── devcontainer        # open vs inside the container
├── docker-compose.yml  # Container orchestration file.
├── Makefile            # automation commands
├── mlruns	            # save all runs from machine learning
└── README.md           # project overview
```

## 🐳 Docker Setup
# Use docker in two ways:
# Using a single docker to make all the quick exercises.
# Use docker-compose to setup an entire dev ecosystem with multiple applications like Postgres, MLflow.



# Image and container setup
IMAGE_NAME = ml-course
CONTAINER_NAME = ml-course-container
DEBUG_CONTAINER = $(CONTAINER_NAME)-debug-$(shell date +%s)
PORT = 8888
ENV_FILE = .env
NOTEBOOK_DIR = $(PWD)/notebooks

## ─────────────────────────────────────────────
## 🐳 Docker (manual control)
## ─────────────────────────────────────────────

build:
	@if [ -z "$$(docker images -q $(IMAGE_NAME))" ]; then \
		echo "🔨 Building image..."; \
		docker build -t $(IMAGE_NAME) .; \
	else \
		echo "✅ Image $(IMAGE_NAME) already exists."; \
	fi

run-env:
	docker run -it --rm \
		--env-file $(ENV_FILE) \
		-v $(PWD):/app \
		$(IMAGE_NAME)

run-named:
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-v $(PWD):/app \
		$(IMAGE_NAME)

shell:
	docker run -it --rm \
		--name $(DEBUG_CONTAINER) \
		-v $(PWD):/app \
		$(IMAGE_NAME) \
		bash

notebook:
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-p $(PORT):8888 \
		-v $(NOTEBOOK_DIR):/app/notebooks \
		$(IMAGE_NAME) \
		jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=''

## ─────────────────────────────────────────────
## 🧩 Docker Compose (stack orchestration)
## ─────────────────────────────────────────────

compose-up:
	docker-compose up --build

compose-down:
	docker-compose down

compose-logs:
	docker-compose logs -f notebook

compose-restart:
	docker-compose restart

compose-shell:
	docker-compose exec notebook bash

## ─────────────────────────────────────────────
## 🧹 Maintenance
## ─────────────────────────────────────────────

push:
	git add .
	git commit -m "Update ML course setup"
	git push

clean:
	docker rmi $(IMAGE_NAME) || true

clean-all:
	docker container prune -f
	docker volume prune -f
	docker rmi $(IMAGE_NAME) || true

## 📦 Python Dependencies

List your packages in `requirements.txt`. Example:

```

## DevContainer file
#### create a json file with the next configuration and make sure you have __ms-vscode-remote.remote-containers__ extension installed in VS Code.

``` 
{
  "name": "ML Course Dev",
  "dockerComposeFile": "../docker-compose.yml",
  "service": "notebook",
  "workspaceFolder": "/app",
  "remoteUser": "root",
  "settings": {
    "python.pythonPath": "/usr/local/bin/python"
  },
  "extensions": [
    "ms-python.python",
    "ms-toolsai.jupyter"
  ],
  "mounts": [
    "source=${localWorkspaceFolder}/notebooks,target=/app/notebooks,type=bind"
  ],
  "postCreateCommand": "pip install -r requirements.txt"
}

```

# Core ML libraries
numpy
pandas
scikit-learn
matplotlib
seaborn

# Jupyter
jupyter

# MLflow SDK
mlflow

# PostgreSQL driver
psycopg2-binary

# Optional: experiment tracking, model serving
xgboost
lightgbm
torch

```

## 🧪 Notes

- This setup assumes Docker and WSL2 are already installed.
- All code runs inside the container; your local environment stays clean.
- You can mount datasets or notebooks via the `/app` volume.
- Make sure you have installed docker-compose in WSL

```  
sudo apt update && sudo apt install docker-compose

´´´
---

Happy modeling! 🧬
```

---


