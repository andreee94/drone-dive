# Dive plugin for Drone CI

This plugin let to run [dive](https://github.com/wagoodman/dive) 
commands in a [drone ci](https://www.drone.io/) pipeline.

## Example with settings

---
The plugin requires to mount the `docker.sock` file.
This is a limitation of dive.

Unfortunately drone ci does not support yet `podman`.

---

The following example shows how to access a private registry with self signed key. 

```yaml
kind: pipeline
type: kubernetes
name: default

steps:
- name: dive
  image: 127.0.0.1:5000/drone-dive:0.10.0
  settings:
    images:
    - alpine:latest
    - alpine/git:latest

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