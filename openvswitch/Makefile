VER:=2.12.4
REL:=4
tag:=$(VER)-$(REL)

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/openvswitch

img:=$(REPO):$(tag)
platform?=linux/amd64,linux/arm64,linux/riscv64

all: build

build:
	docker buildx build --platform $(platform) -t $(img) .

push:
	docker buildx build --platform $(platform) -t $(img) . --push
