REGISTRY ?= "registry.cn-beijing.aliyuncs.com/yunionio"
VERSION ?= "3.5.12"
platform ?= linux/amd64,linux/arm64,linux/riscv64

build:
	docker buildx build --platform $(platform) -t $(REGISTRY)/etcd:$(VERSION) -f Dockerfile . --push
