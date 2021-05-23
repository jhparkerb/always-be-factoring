#!/bin/bash

set -e

REGISTRY=gcr.io/always-be-factoring

for d in build gmp cado server client
do
	docker build -t $d $d
done

for d in server client
do
	docker tag $d ${REGISTRY}/$d
	docker push ${REGISTRY}/$d
done
