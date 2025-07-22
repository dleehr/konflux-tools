FROM registry.access.redhat.com/ubi9/python-311:9.6

RUN pip install pybuild-deps
RUN mkdir -p /opt/app-root/src/.cache/pybuild-deps
WORKDIR /tmp
CMD ["pybuild-deps"]
