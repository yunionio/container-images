TAG?=1.4
REGISTRY?=registry.cn-beijing.aliyuncs.com/yunionio

img:=$(REGISTRY)/host-deployer-base:$(TAG)
platform?=linux/amd64,linux/arm64

all: build

build:
	docker buildx build --platform $(platform) -t $(img) .

push:
	docker buildx build --platform $(platform) -t $(img) . --push

