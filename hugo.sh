#!/usr/bin/env bash

docker run --rm -it -p 1313:1313 -v $( pwd ):/src -u hugo jguyomard/hugo-builder hugo "$@"
