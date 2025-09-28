
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
