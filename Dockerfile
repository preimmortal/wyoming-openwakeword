FROM python:3.11-slim-bookworm

ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --yes --no-install-recommends avahi-utils


WORKDIR /app

COPY script/setup ./script/
COPY setup.py requirements.txt MANIFEST.in ./
COPY wyoming_openwakeword/ ./wyoming_openwakeword/

RUN script/setup
RUN .venv/bin/pip3 install --upgrade pip
RUN .venv/bin/pip3 install --upgrade --upgrade wheel setuptools

COPY script/run ./script/
COPY docker/run ./

EXPOSE 10400

ENTRYPOINT ["/app/run"]
