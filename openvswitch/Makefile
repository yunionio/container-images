VER:=2.10.4
REL:=1
tag:=$(VER)-$(REL)

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/openvswitch

img:=$(REPO):$(tag)

all: build

build:
	docker buildx build --platform linux/amd64,linux/arm64 -t $(img) . --push
