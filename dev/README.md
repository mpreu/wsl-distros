# Custom WSL Distribution based on Fedora

Build requirements:

- podman
- gzip

Build the distribution `tar.gz` via:

```bash
make
```

Install the distribution:

```bash
wsl --install \
    --location $HOME\.wsl2\distros\dev \ 
    --name dev \
    --from-file dev.tar.gz
```

## Customizations

You can place certificates in `.pem` format [here](./rootfs/etc/pki/ca-trust/source/anchors/) to automatically update the trust store.

## Initial Setup

```bash
# Seems currently necessary to get a working dbus in 
# combination with active lingering.
sudo systemctl restart user@1000

# Workaround for wayland socket with wrong permissions.
systemctl --user enable --now wayland-socket.service
```
