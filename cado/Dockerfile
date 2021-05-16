FROM debian:buster as build

ENV PKG_ROOT "/pkg"

RUN useradd -m build

RUN mkdir -p /pkg && \
	chown -R build:build ${PKG_ROOT}

USER build

WORKDIR /home/build

# Build GMP
ENV GMP_ROOT ${PKG_ROOT}/gmp

ENV GMP_VERSION 6.2.1

ENV GMP_BUILD_DEPS " \
	build-essential \
	ca-certificates \
	curl \
	m4 \
	"

USER root

RUN apt-get -y update && \
	apt-get -y --no-install-recommends install \
		$GMP_BUILD_DEPS

USER build

RUN curl -L -O https://ftp.gnu.org/gnu/gmp/gmp-${GMP_VERSION}.tar.bz2 && \
	tar jxf gmp-${GMP_VERSION}.tar.bz2

WORKDIR gmp-${GMP_VERSION}

RUN CFLAGS="-O3 -march=native -W -Wall" \
	CFLAGS="-O3 -march=native -W -Wall" \
	./configure \
		--enable-cxx \
		--prefix=${GMP_ROOT} && \
	make -s -j$(nproc) && \
	make -s check && \
	make -s install

WORKDIR ..

# Build CADO-NFS
ENV CADO_ROOT ${PKG_ROOT}/cado

ENV CADO_REV 44349958caa4f93b7708a5a5a8bf33ebe49c3a83

ENV CADO_BUILD_DEPS " \
	cmake \
	git \
	python3 \
	"

USER root

RUN apt-get -y update && \
	apt-get -y --no-install-recommends install \
		$CADO_BUILD_DEPS

USER build

RUN git clone https://gitlab.inria.fr/cado-nfs/cado-nfs.git && \
	cd cado-nfs && \
	git checkout ${CADO_REV}

WORKDIR cado-nfs

RUN FLAGS_SIZE="-DSIZEOF_P_R_VALUES=8 -DSIZEOF_INDEX=8" \
	CFLAGS="-Ofast -march=native -W -Wall -DNDEBUG" \
	CXXFLAGS="-Ofast -march=native -W -Wall -DNDEBUG" \
	GMP="${GMP_ROOT}" \
	PREFIX="${CADO_ROOT}" \
		make -s -j$(nproc) install

# Package into a runtime container
FROM debian:buster as cado

COPY --from=build /pkg /pkg

ENV DEPS " \
	curl \
	gzip \
	libgomp1 \
	openssl \
	perl \
	python \
	python3 \
	ssh \
	tzdata \
	"

RUN apt-get -y update && \
	apt-get -y --no-install-recommends install \
		$DEPS && \
	useradd -m cado

RUN echo /pkg/gmp/lib | tee /etc/ld.so.conf.d/gmp.conf && \
	ldconfig -v

USER cado

ENV TZ "US/Eastern"

WORKDIR /home/cado
