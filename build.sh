#!/bin/bash

. /etc/lsb-release
export DISTRIB="${DISTRIB_ID}-${DISTRIB_RELEASE}"
export SDKROOT=${SDKROOT:-/opt/python-wasm-sdk}
export CIVER=${CIVER:-$DISTRIB}

TAG=emsdk

echo "making sdk-extra $TAG tarball" 1>&2

pushd /
mkdir -p /tmp/sdk
tar -cpPR \
    ${SDKROOT}/config \
    ${SDKROOT}/python3-was? \
    ${SDKROOT}/wasm32-*-shell.sh \
    ${SDKROOT}/*sdk \
    ${SDKROOT}/scripts/*sdk-fetch.sh \
    ${SDKROOT}/devices/* \
    ${SDKROOT}/prebuilt/* \
     > /tmp/sdk/python${PYBUILD}-${TAG}-sdk-extra-${CIVER}.tar

    lz4 -c --favor-decSpeed --best /tmp/sdk/python${PYBUILD}-${TAG}-sdk-extra-${CIVER}.tar \
     > /tmp/sdk/python${PYBUILD}-${TAG}-sdk-extra-${CIVER}.tar.lz4

echo "done"  1>&2
popd
