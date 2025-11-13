REGISTRY ?= "registry.cn-beijing.aliyuncs.com/yunionio"
VERSION ?= "v4.0.0-20251112.0"
platform ?= linux/amd64,linux/arm64,linux/riscv64

build:
	docker buildx build --platform $(platform) -t $(REGISTRY)/web-base:$(VERSION) -f Dockerfile . --push