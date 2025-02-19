FROM ubuntu:20.04

ARG BUILD_DATE
ARG HPOOL_VERSION
ARG DOCKER_VERSION
LABEL build_version="Hpool Miner Version:- 1.6.0 Docker Version:- ${DOCKER_VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="HerrSchnell"

WORKDIR /hpool

RUN mkdir -p /hpool /plots

RUN apt update \
        && apt update \
        && apt install zip unzip curl wget git -y

RUN wget -O /hpool/miner.zip https://github.com/hpool-dev/chia-miner/releases/download/1.6.0/HPool-Miner-chia-og-v1.6.0-1-linux.zip \
	&& wget -O /hpool/plotter.zip https://github.com/hpool-dev/chia-plotter/releases/download/v0.11/chia-plotter-v0.11-x86_64-linux-gnu.zip \
    && unzip miner.zip \
	&& unzip plotter.zip \
    && mv linux/* /hpool \
	&& mv chia-plotter/chia-plotter-linux-amd64 /hpool/plot-sign \
	&& mv hpool-miner-chia-linux-amd64 miner \
    && rm -R linux/ __MACOSX/ chia-plotter/ plotter.zip miner.zip config.yaml

CMD ["/hpool/miner"]
