REPO?=registry.cn-beijing.aliyuncs.com/yunionio/calico-node
VERSION:=v3.12.1
REL:=ipset-6
TAG:=$(VERSION)-$(REL)

IMG:=$(REPO):$(TAG)

all: image

image:
	docker buildx build -t $(IMG)-amd64 -f ./Dockerfile.amd64 --push --platform linux/amd64 .
	docker pull --platform "linux/amd64" $(IMG)-amd64
	docker pull --platform "linux/arm64" $(REPO):$(VERSION)

manifest: image
	docker buildx imagetools create -t $(IMG) $(IMG)-amd64 $(REPO):$(VERSION)
	docker manifest inspect $(IMG)
