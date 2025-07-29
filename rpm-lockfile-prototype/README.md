# rpm-lockfile-prototype

Containerfile for [rpm-lockfile-prototype](https://github.com/konflux-ci/rpm-lockfile-prototype)

## Overview

The tool is python-based but depends on the Linux-only package `python3-dnf`, so on non-Linux platforms we use a container.
While the linked repo includes a `Containerfile` for running [rpm-lockfile-prototype](https://github.com/konflux-ci/rpm-lockfile-prototype),
that repo does not install `git`, which is needed for my use case.

## Building

```
podman build -t rpm-lockfile-prototype .
```

## Running

In your directory containing `rpms.in.yaml`:

```
podman run \
  -e GIT_SSL_NO_VERIFY=true \
  -v $PWD:/data \
  rpm-lockfile-prototype:latest  \
  --image registry.access.redhat.com/ubi9/ubi-minimal:latest \
  /data/rpms.in.yaml \
  --outfile /data/rpms.lock.yaml
```

### Why these arguments?

- `-e GIT_SSL_NO_VERIFY=true` because the container does not trust the CA certificate of our gitlab server.
  - Obviously there is low-hanging fruit here to improve this.
- `-v $PWD:/data` to mount the directory containing `rpms.in.yaml` into the container at a known location
- `rpm-lockfile-prototype:latest` the image for podman to run
- `--image registry.access.redhat.com/ubi9/ubi-minimal:latest`: The image to **process**.
  - `rpm-lockfile-prototype` will use this image here as the base when it decides what RPMs to pull in, so a `ubi-minimal` image is probably the right choice.
  - Note that I'm using `registry.access.redhat.com` because it allows unauthenticated pulls. If we used `registry.redhat.io` here, we'd need to pass auth so that `skopeo` inside our container could access the registry.
- `--outfile /data/rpms.lock.yaml` Write the lockfile in the mounted `/data` directory, which is our PWD.

Happy locking
