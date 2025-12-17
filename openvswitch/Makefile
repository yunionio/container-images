VER:=2.12.4
REL:=20251218
tag:=$(VER)-$(REL)

REGISTRY?=registry.cn-beijing.aliyuncs.com/yunionio

img:=$(REGISTRY)/openvswitch:$(tag)
platform?=linux/amd64,linux/arm64,linux/riscv64

all: build

build:
	docker buildx build --platform $(platform) -t $(img) .

push:
	docker buildx build --platform $(platform) -t $(img) . --push
	echo $(img)
