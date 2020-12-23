VER:=1.1
REL:=3
tag:=$(VER)-$(REL)

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/centos-build

img:=$(REPO):$(tag)
platform?=linux/amd64,linux/arm64

docker-hub-repo:=yunionio/centos-build
docker-hub-img:=$(docker-hub-repo):$(tag)

all: build

build:
	docker buildx build --platform $(platform) -t $(img) .

push:
	docker buildx build --platform $(platform) -t $(img) . --push

# This is for clients with faster access to docker hub registry than aliyun's.
# Previously this was known as yunionio/onecloud-ci
push-docker-hub:
	docker tag $(img) $(docker-hub-img)
	docker push $(docker-hub-img)
