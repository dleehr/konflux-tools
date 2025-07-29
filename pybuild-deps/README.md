# pybuild-deps

Containerfile for [pybuild-deps](https://github.com/hermetoproject/pybuild-deps)

## Overview

The tool is python-based but version specific, so I built a Containerfile to simplify.

## Building

```
podman build -t pybuild-deps .
```

## Running

In your directory containing `requirements.txt`:

```
podman run -v $PWD:/data pybuild-deps pybuild-deps compile --generate-hashes --output-file=requirements-build.txt requirements.txt
```


