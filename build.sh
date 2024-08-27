#!/bin/bash

if cd /opt/python-wasm-sdk
then
    find . -type f > sdk.base
    . scripts/emsdk-extra.sh
fi


