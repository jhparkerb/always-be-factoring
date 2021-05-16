FROM debian:buster as build

ENV PKG_ROOT "/pkg"

ENV BUILD_DEPS " \
	build-essential \
	ca-certificates \
	"

USER root

RUN apt-get -y update && \
	apt-get -y --no-install-recommends install \
		$BUILD_DEPS

RUN useradd -m build

RUN mkdir -p ${PKG_ROOT} && \
	chown -R build:build ${PKG_ROOT}

USER build

WORKDIR /home/build
