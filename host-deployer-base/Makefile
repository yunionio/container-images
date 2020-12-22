TAG?=0.6
REGISTRY?=registry.cn-beijing.aliyuncs.com/yunionio

img:=$(REGISTRY)/host-deployer-base:$(TAG)

all: build

build:
	docker buildx build --platform linux/arm64,linux/amd64 -t $(img) . --push
	docker pull $(img)

push:
	docker push $(img)

