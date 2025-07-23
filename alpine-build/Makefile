VER:=1.1
REL:=5
tag:=$(VER)-$(REL)

REPO?=registry.cn-beijing.aliyuncs.com/yunionio/alpine-build

img:=$(REPO):$(tag)

docker-hub-repo:=yunionio/alpine-build
docker-hub-img:=$(docker-hub-repo):$(tag)

all: build

build:
	docker buildx build --platform linux/arm64,linux/amd64 -t $(img) . --push
	docker pull $(img)

build-3-15-4:
	docker buildx build -f ./Dockerfile.3-15-4 --platform linux/arm64,linux/amd64 -t $(REPO):3.15.4-0 . --push
	docker pull $(REPO):3.15.4-0

VERSION_3160_GO_1182=3.16.0-go-1.18.2-0
build-3.16.0-go-1.18.2:
	docker buildx build -f ./Dockerfile.3.16.0-go-1.18.2 --platform linux/arm64,linux/amd64 -t $(REPO):$(VERSION_3160_GO_1182) . --push
	docker pull $(REPO):$(VERSION_3160_GO_1182)

VERSION_3180_GO_12011=3.18.0-go-1.20.11-0
build-3.18.0-go-1.20.11:
	docker buildx build -f ./Dockerfile.3.18.0-go-1.20.11 --platform linux/arm64,linux/amd64 -t $(REPO):$(VERSION_3180_GO_12011) . --push
	docker pull $(REPO):$(VERSION_3180_GO_12011)

VERSION_3190_GO_12110=3.19.0-go-1.21.10-0
build-3.19.0-go-1.21.10:
	docker buildx build -f ./Dockerfile.3.19.0-go-1.21.10 --platform linux/arm64,linux/amd64 -t $(REPO):$(VERSION_3190_GO_12110) . --push
	docker pull $(REPO):$(VERSION_3190_GO_12110)

VERSION_3210_GO_12340=3.21.0-go-1.23.4-0
build-3.21.0-go-1.23.4:
	docker buildx build -f ./Dockerfile.3.21.0-go-1.23.4 --platform linux/arm64,linux/amd64,linux/loong64 -t $(REPO):$(VERSION_3210_GO_12340) . --push
	docker pull $(REPO):$(VERSION_3210_GO_12340)

push:
	docker push $(img)

# This is for clients with faster access to docker hub registry than aliyun's.
# Previously this was known as yunionio/onecloud-ci
push-docker-hub:
	docker tag $(img) $(docker-hub-img)
	docker push $(docker-hub-img)
