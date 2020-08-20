tag:=v0.3.0

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/host-base

img:=$(REPO):$(tag)

all: build

build:
	docker build -t $(img) --squash .

push:
	docker push $(img)
