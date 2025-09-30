# 📘 `README.md` to make all this explainable
---

## SETUP YOUR ENVIROMENT

#### HOW TO MOUNT A CONTAINER IN DOCKER TO RUN ALL YOUR ML APPLICATIONS

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
### Use docker in two ways: 
	Use a single docker to make all the quick exercises.
	Use docker-compose to setup an entire dev ecosystem with multiple applications like Postgres, MLflow.

# Image and container setup - VARIABLES
### EXAMPLES

PROVIDE THE VARIABLES: 

``` 
IMAGE_NAME = <image_name>
CONTAINER_NAME = <name-container>
DEBUG_CONTAINER = $(CONTAINER_NAME)-debug-$(shell date +%s)
PORT = 8888
ENV_FILE = .env
NOTEBOOK_DIR = $(PWD)/notebooks
```

ENSURE YOU HAVE A .env file and follow the structure of the folder system.

### CHECK the MAKE FILE

../Makefile 

### You will see three sections: 
	Docker (manual control): Quick Dev without compose the entire solution
	Docker Compose (stack orchestration): Build and orchestate several applications to integrate a solution
	Maintenance: Maintain your progress clear and update your repo


## 📦 Python Dependencies

List your packages in `requirements.txt`. Example:

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



## 🧪 Notes

- This setup assumes Docker and WSL2 are already installed.
- All code runs inside the container; your local environment stays clean.
- You can mount datasets or notebooks via the `/app` volume.
- Make sure you have installed docker-compose in WSL: 
```  
sudo apt update && sudo apt install docker-compose
```
- To work with simple notebooks in Jupyter or Jupyter Lab run your notebook in the docker.
If you have not build your image:

```
make build (if you have not build your image yet) 
```
Run your notebook inside the docker
```
make notebook 
```

If you want to edit your code scripts or Notebooks inside VS Code then compose the entire docker system.
```
make compose-up
```
---
Happy modeling! 🧬





