#!/bin/bash

export SDKROOT=${SDKROOT:-/opt/python-wasm-sdk}

if cd $SDKROOT
then
    find . -type f > sdk.base
    . scripts/emsdk-extra.sh
fi


