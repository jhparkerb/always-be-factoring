#!/bin/bash

set -e

REGISTRY=gcr.io/always-be-factoring

for d in build gmp cado
do
	docker build -t $d $d
done

for d in cado
do
	docker tag $d ${REGISTRY}/$d
	docker push ${REGISTRY}/$d
done
