REGISTRY ?= "registry.cn-beijing.aliyuncs.com/cloudpods"
VERSION ?= "cu128-slim.20260324.0"
platform ?= linux/amd64

build:
	docker buildx build --platform $(platform) -t $(REGISTRY)/comfyui-boot:$(VERSION) -f Dockerfile . --push
