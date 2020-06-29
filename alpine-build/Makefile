VER:=1.0
REL:=2
tag:=$(VER)-$(REL)

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/alpine-build

img:=$(REPO):$(tag)

all: build

build:
	docker build -t $(img) --squash .

push:
	docker push $(img)
