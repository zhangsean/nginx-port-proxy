# nginx-port-proxy
Simple and high performance TCP and UDP port proxy based on Nginx.

Specially useful for proxying some port from running containers which didn't expose some port when it starting for security reason.

Specially useful for exposing a TCP port proxy to an internal service on a gateway server too.

[![DockerHub Badge](http://dockeri.co/image/zhangsean/nginx-port-proxy)](https://hub.docker.com/r/zhangsean/nginx-port-proxy/)


## Usage

#### Simple run:
```shell
# Run with arguments
docker run -d --name ssh-proxy -p 2222:80 zhangsean/nginx-port-proxy 192.168.0.100:22

docker run -d --name dns-proxy -p 53:80/udp zhangsean/nginx-port-proxy 8.8.8.8:53/udp

# Run with environment variables
docker run -d --name myproxy \
 -e LISTEN_PORT=84 \
 -e PROTO=tcp \
 -e REMOTE_SERVER=example.com \
 -e REMOTE_PORT=443 \
 -p 8443:84 \
 zhangsean/nginx-port-proxy
```

#### Web example:
```shell
# Run a web server
docker run --name web -p 80:80 -d zhangsean/hello-web

# Run a port proxy with link
docker run --name web-proxy -p 8000:80 --link web:web -d zhangsean/nginx-port-proxy web:80

# Run a port proxy with direct ip and port
docker run --name web-proxy -p 8000:80 -d zhangsean/nginx-port-proxy 172.17.0.2:80
```

#### TCP example:
```shell
# Run a mysql server
docker run --name mysql -d mysql

# Run a port proxy with link
docker run --name mysql-proxy -p 3306:80 --link mysql:mysql -d zhangsean/nginx-port-proxy mysql:3306
```

#### UDP example:
```shell
# Run a dns server
docker run --name dns -d jpillora/dnsmasq

# Run a port proxy with link
docker run -d --name dns-proxy --link dns:dns -p 53:80/udp zhangsean/nginx-port-proxy dns:53/udp
```

## Environment variables
Variable name|Default|Description
---|---|---
LISTEN_PORT | 80 | The port which nginx listened on in continaer.
PROTO | tcp | The proto which nginx listened on and proxy to.
REMOTE_SERVER | example.com | Remote server name or IP which nginx proxy to.
REMOTE_PORT | 80 | Remote port which nginx proxy to.


## References
* [Nginx docs: TCP and UDP Load Balancing](https://docs.nginx.com/nginx/admin-guide/load-balancer/tcp-udp-load-balancer/)
* [Nginx docs: Module ngx_stream_proxy_module](https://nginx.org/en/docs/stream/ngx_stream_proxy_module.html)