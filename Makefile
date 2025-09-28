# Makefile for ML Course Docker Setup

IMAGE_NAME = ml-course
CONTAINER_NAME = ml-course-container
DEBUG_CONTAINER = $(CONTAINER_NAME)-debug-$(shell date +%s)
PORT = 8888
ENV_FILE = .env
NOTEBOOK_DIR = $(PWD)/notebooks

## 🐳 Build the Docker image (only if not already built)
build:
	@if [ -z "$$(docker images -q $(IMAGE_NAME))" ]; then \
		echo "🔨 Building image..."; \
		docker build -t $(IMAGE_NAME) .; \
	else \
		echo "✅ Image $(IMAGE_NAME) already exists."; \
	fi

## 🧪 Run container with bash access and environment variables
run-env:
	docker run -it --rm \
		--env-file $(ENV_FILE) \
		-v $(PWD):/app \
		$(IMAGE_NAME)

## 🧾 Run container with named instance (no env file)
run-named:
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-v $(PWD):/app \
		$(IMAGE_NAME)

## 🐚 Debug shell with dynamic container name
shell:
	docker run -it --rm \
		--name $(DEBUG_CONTAINER) \
		-v $(PWD):/app \
		$(IMAGE_NAME) \
		bash

## Launch Jupyter Notebook
notebook:
	docker run -it --rm \
		--name $(CONTAINER_NAME) \
		-p $(PORT):8888 \
		-v $(NOTEBOOK_DIR):/app/notebooks \
		$(IMAGE_NAME) \
		jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser --allow-root --NotebookApp.token=''

## Push changes to GitHub
push:
	git add .
	git commit -m "Update ML course setup"
	git push

## Clean Docker image
clean:
	docker rmi $(IMAGE_NAME) || true

## Clean all containers and volumes
clean-all:
	docker container prune -f
	docker volume prune -f
	docker rmi $(IMAGE_NAME) || true
