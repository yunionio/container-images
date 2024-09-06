TAG?=1.4.8
REGISTRY?=registry.cn-beijing.aliyuncs.com/yunionio


img:=$(REGISTRY)/host-deployer-base:$(TAG)
platform?=linux/amd64,linux/arm64

qgaTag=qga-v1.0
qgaImg:=$(REGISTRY)/host-deployer-base:$(qgaTag)

telegrafTAG=v20240905.0
telegrafImg:=$(REGISTRY)/telegraf:$(telegrafTAG)

superviseTag=v1.0
superviseImg:=$(REGISTRY)/supervise:$(superviseTag)

baseTag=base-v1.0
baseImg:=$(REGISTRY)/host-deployer-base:$(baseTag)


docker_args ?=

all: push

qga-build:
	docker buildx build $(docker_args) --platform $(platform) -t $(qgaImg) -f ./Dockerfile.qga . --push

telegraf-build:
	docker buildx build $(docker_args) --platform $(platform) -t $(telegrafImg) -f ./Dockerfile.telegraf . --push

supervise-build:
	docker buildx build $(docker_args) --platform $(platform) -t $(superviseImg) -f ./Dockerfile.supervise . --push

base-of-base:
	docker buildx build $(docker_args) --platform $(platform) -t $(baseImg) -f ./Dockerfile.base . --push

build:
	docker buildx build $(docker_args) --platform $(platform) -t $(img) .

push:
	docker buildx build $(docker_args) --platform $(platform) -t $(img) . --push

clean:
	rm -f *.o
