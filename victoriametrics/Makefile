REGISTRY ?= "registry.cn-beijing.aliyuncs.com/yunionio"
VERSION ?= "v1.129.1-1"
platform ?= linux/amd64,linux/arm64,linux/riscv64

build:
	docker buildx build --platform $(platform) -t $(REGISTRY)/victoria-metrics:$(VERSION) -f Dockerfile . --push
