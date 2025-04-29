.PHONY: dev
dev:
	podman build \
	  	--no-cache \
	  	-t dev \
	  	-f Containerfile \
	  	--build-context rootfs=https://download.fedoraproject.org/pub/fedora/linux/releases/42/Container/x86_64/images/Fedora-WSL-Base-42-1.1.x86_64.tar.xz \
	  	.
	podman create --name dev dev
	podman export -o dev.tar dev
	gzip dev.tar
	podman rm dev
