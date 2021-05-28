# Dive plugin for Drone CI [![Build Status](http://192.168.1.102:3334/api/badges/gitea_admin/drone-dive/status.svg)](http://192.168.1.102:3334/gitea_admin/drone-dive)

This plugin allows to run [dive](https://github.com/wagoodman/dive) 
command in a [drone ci](https://www.drone.io/) pipeline.

## Example with settings

---
The plugin requires to mount the `docker.sock` file.
This is a limitation of dive.

Unfortunately drone ci does not support `podman` yet.

---

The following example shows how to check:
- an image on a public registry
- an image on a private registry with self signed key. 

```yaml
kind: pipeline
type: kubernetes
name: default

steps:
- name: dive-public 
  image: 127.0.0.1:5000/drone-dive:0.10.0
  settings:
    images:
    - alpine:latest
    - alpine/git:latest
  environment:
    DOCKER_HOST: unix:///var/run/docker.sock #unix:///drone/docker.sock
  volumes:
    - name: dockersock
      path: /var/run


- name: dive-private
  image: 127.0.0.1:5000/drone-dive:0.10.0
  environment:
    DOCKER_HOST: unix:///var/run/docker.sock #unix:///drone/docker.sock
    REGISTRY_USERNAME:
      from_secret: registry_username
    REGISTRY_PASSWORD:
      from_secret: registry_password
  commands:
    - echo "$REGISTRY_PASSWORD" > ~/docker_password.txt
    - cat ~/docker_password.txt | docker login 127.0.0.1:5000 --username "$REGISTRY_USERNAME" --password-stdin
    - dive 127.0.0.1:5000/drone-dive:0.10.0
  volumes:
    - name: dockersock
      path: /var/run

services:
- name: docker
  image: docker:dind
  privileged: true
  command: ["--insecure-registry", "127.0.0.1:5000"]
  volumes:
  - name: dockersock
    path: /var/run

volumes:
- name: dockersock
  temp: {}

image_pull_secrets:
- registry_secrets_json
```