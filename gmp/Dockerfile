FROM build as gmp_build

ENV GMP_ROOT ${PKG_ROOT}/gmp

ENV GMP_VERSION 6.2.1

ENV GMP_BUILD_DEPS " \
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

FROM scratch as gmp

COPY --from=gmp_build /pkg/gmp /pkg/gmp
