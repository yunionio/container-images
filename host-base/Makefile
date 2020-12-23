tag:=v0.4.0

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/host-base

img:=$(REPO):$(tag)
platform?=linux/amd64,linux/arm64

all: build

build:
	docker buildx build --platform $(platform) -t $(img) .

push:
	docker buildx build --platform $(platform) -t $(img) . --push
