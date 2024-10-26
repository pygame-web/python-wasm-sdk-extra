#!/bin/bash

export PYDK_CC=true

if cd /opt/python-wasm-sdk
then
    find . -type f > sdk.base
    . scripts/emsdk-extra.sh
fi


