#!/bin/bash

. /etc/lsb-release
export DISTRIB="${DISTRIB_ID}-${DISTRIB_RELEASE}"
export SDKROOT=${SDKROOT:-/opt/python-wasm-sdk}
export CIVER=${CIVER:-$DISTRIB}

TAG=emsdk

pushd /opt/python-wasm-sdk
    echo "Removing $(wc -l sdk.base) files belonging to SDK"
    for sdkfile in $(cat sdk.base)
    do
        rm $sdkfile
    done
popd

echo "Making sdk-extra $TAG tarball" 1>&2


pushd /
    mkdir -p /tmp/sdk

    cat > ${SDKROOT}/extra.installed <<END
EXTRA_PYBUILD=${PYBUILD}
EXTRA_TAG=
EXTRA_CIVER=${CIVER}
END

    tar -cpPR \
    ${SDKROOT}/extra.installed
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

    du -hs /tmp/sdk/*

    rm /tmp/sdk/python${PYBUILD}-${TAG}-sdk-extra-${CIVER}.tar
    echo "done"  1>&2
popd
