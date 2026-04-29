TAG?=1.5.11
REGISTRY?=registry.cn-beijing.aliyuncs.com/yunionio


img:=$(REGISTRY)/host-deployer-base:$(TAG)
platform?=linux/amd64,linux/arm64,linux/riscv64

qgaTag=qga-v4.0.0
qgaImg:=$(REGISTRY)/host-deployer-base:$(qgaTag)

telegrafTAG=v1.36-20260227.0
telegrafImg:=$(REGISTRY)/telegraf:$(telegrafTAG)

superviseTag=v2.0
superviseImg:=$(REGISTRY)/supervise:$(superviseTag)

baseTag=base-v2.2
baseImg:=$(REGISTRY)/host-deployer-base:$(baseTag)

nbdkitTag=nbdkit-v1.46.2-0
nbdkitImg:=$(REGISTRY)/host-deployer-base:$(nbdkitTag)

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

nbdkit-build:
	docker buildx build $(docker_args) --platform $(platform) -t $(nbdkitImg) -f ./Dockerfile.nbdkit . --push

build:
	docker buildx build $(docker_args) --platform $(platform) -t $(img) .

push:
	docker buildx build $(docker_args) --platform $(platform) -t $(img) . --push

clean:
	rm -f *.o
