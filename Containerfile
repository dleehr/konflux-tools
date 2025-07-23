FROM registry.access.redhat.com/ubi9/ubi:latest

# Install dependencies
RUN dnf update -y && \
    dnf install -y git python3 python3-pip python3-dnf skopeo && \
    dnf clean all

# Clone and install rpm-lockfile-prototype
RUN git clone https://github.com/konflux-ci/rpm-lockfile-prototype.git /opt/rpm-lockfile-prototype

WORKDIR /opt/rpm-lockfile-prototype

# Install Python dependencies if requirements exist
RUN if [ -f requirements.txt ]; then pip3 install -r requirements.txt; fi && \
    if [ -f setup.py ]; then pip3 install -e .; fi && \
    if [ -f pyproject.toml ]; then pip3 install -e .; fi


ENTRYPOINT ["rpm-lockfile-prototype"]
