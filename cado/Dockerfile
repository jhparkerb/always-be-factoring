FROM build as cado_build

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

COPY --from=gmp /pkg/gmp /pkg/gmp

ENV PKG_ROOT /pkg

ENV GMP_ROOT ${PKG_ROOT}/gmp

ENV CADO_ROOT ${PKG_ROOT}/cado

ENV CADO_REV a515a8367a3df27792214b1c33b33a308069fb62

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

FROM debian:buster as cado

COPY --from=gmp /pkg/gmp /pkg/gmp
COPY --from=cado_build /pkg/cado /pkg/cado

ENV RUNTIME_DEPS " \
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
		$RUNTIME_DEPS && \
	useradd -m cado

RUN echo /pkg/gmp/lib | tee /etc/ld.so.conf.d/gmp.conf && \
	ldconfig -v

USER cado

ENV TZ "US/Eastern"

WORKDIR /home/cado
