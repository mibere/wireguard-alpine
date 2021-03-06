[![Build](https://github.com/mibere/wireguard-alpine/actions/workflows/publish-image.yml/badge.svg?branch=main)](https://github.com/mibere/wireguard-alpine/actions/workflows/publish-image.yml)

Image for my personal use, not for the general public. Based on [Alpine Linux (edge)](https://www.alpinelinux.org/).

### Download pre-built Docker image for _armv7_
```
docker pull ghcr.io/mibere/wireguard-alpine
```

### or build locally
```
mkdir ~/docker-builds
cd ~/docker-builds
git clone https://github.com/mibere/wireguard-alpine.git
cd wireguard-alpine
docker build -t wireguard-alpine --pull --no-cache .
docker rmi $(docker images -qa -f "dangling=true")
```

### Preparations on the host
```
sudo nano /etc/sysctl.d/99-sysctl.conf
```

> net.ipv6.conf.all.disable_ipv6 = 1  
> net.ipv4.ip_forward = 1  
> net.core.rmem_default = 2097152  
> net.core.rmem_max = 4194304  
> net.core.wmem_default = 2097152  
> net.core.wmem_max = 4194304  
> #net.core.somaxconn = (a minimum value of 256)

```
sudo sysctl -p
```

### Start container for the first time
:exclamation: **Adapt the values for _DNS_ and _ENDPOINT_**

```
docker volume create wireguard
docker run --name=wireguard -e DNS="192.168.1.1" -e ENDPOINT="my.dyn.dns" --restart=always --cap-add SYS_MODULE --cap-add NET_ADMIN --network=host -v wireguard:/etc/wireguard/ -d ghcr.io/mibere/wireguard-alpine
```

Show smartphone configuration as QR-code:
```
docker exec -it wireguard qrencode -t ansiutf8 -r "/etc/wireguard/clients/smartphone.conf"
```

### Update existing container
:exclamation: **Adapt the values for _DNS_ and _ENDPOINT_** (see running container `docker exec -it wireguard env`)

```
docker stop wireguard
docker rm wireguard
docker pull ghcr.io/mibere/wireguard-alpine
docker run --name=wireguard -e DNS="192.168.1.1" -e ENDPOINT="my.dyn.dns" --restart=always --cap-add SYS_MODULE --cap-add NET_ADMIN --network=host -v wireguard:/etc/wireguard/ -d ghcr.io/mibere/wireguard-alpine
```
<br/>
:point_right: WireGuard is listening on port 48651
