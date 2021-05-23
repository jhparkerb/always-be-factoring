#!/bin/bash

# Fill in a default argument for --bindir to avoid binary downloads from the
# server.
#
# Run as docker run --net host  client --server http://ADDRESS:37771/

DRY_RUN=""

exec ${DRY_RUN} /pkg/cado/bin/cado-nfs-client.py \
	--bindir=/pkg/cado/lib/cado-nfs-3.0.0 \
	"$@"
