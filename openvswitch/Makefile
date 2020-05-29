VER:=2.10.4
REL:=0
tag:=$(VER)-$(REL)

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/openvswitch

img:=$(REPO):$(tag)

all: build

build:
	docker build -t $(img) --squash .

push:
	docker push $(img)
