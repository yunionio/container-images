# 规范

必须谨慎操作，防止意外覆盖生产环境镜像

	make -C openvswitch

# buildx node设定

有两种办法

 - 一种是qemu usermode emulation，信赖tcg翻译，速度较慢，有内核版本依赖
 - 一种是native方法，要求有物理真机

## binfmt_misc with qemu usermode emulation

docker/binfmt依赖binfmt_misc的F标志支持，要求内核版本至少为v4.8

	mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc/
	docker run --rm --privileged docker/binfmt:a7996909642ee92942dcd6cff44b9b95f08dad64

验证，除了`register`, `status`两个文件，应还有qemu-xxx

	ls /proc/sys/fs/binfmt_misc/

验证，输出应为`aarch64```

	docker run --rm -t arm64v8/alpine uname -m

## use remote native builder node

为当前用户（执行docker client的用户）设定好ssh pubkey auth

	docker context create node-aarch64 --docker "host=ssh://user@host:port"
	docker context ls

# 设置docker buildx builder

buildx特性依赖docker 19.03

buildx node添加的顺序很重要，关系到后来build时--platform linux/aarch64,linux/amd64匹配到哪个node

	docker buildx ls
	docker buildx create --name buildx          node-aarch64
	docker buildx create --name buildx --append default
	docker buildx use buildx

验证，应包含一项DRIVER为`docker-container`

	docker buildx ls
