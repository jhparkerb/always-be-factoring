#!/bin/bash

# Fill in some basic arguments, but allow the user to simply specify a port to
# listen on or a dry-run flag.
#
# Specifying a name=<string> parameter and the number to be factored is the
# caller's responsibility and handled by the cado-nfs.py script.
#
# Run as docker run --net host server N name=NAME

PORT=37771
DRY_RUN=""

while getopts "np:" arg; do
	case $arg in
		n)
			DRY_RUN="echo"
			;;
		p)
			PORT=${OPTARG}
			;;
	esac
done
shift $((OPTIND-1))

exec ${DRY_RUN} /pkg/cado/bin/cado-nfs.py \
	--server \
	-w . \
	server.port=${PORT} \
	server.ssl=no \
	server.whitelist=0.0.0.0/0 \
	"$@"
