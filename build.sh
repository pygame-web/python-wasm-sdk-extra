#!/bin/bash

export SDKROOT=${SDKROOT:-/opt/python-wasm-sdk}

if cd $SDKROOT
then
    find . -type f > sdk.base
    if [ -f ${SDKROOT}/wasm-opt.version ]
    then
        echo -n wasm opt removed
    else
        ${SDKROOT}/emsdk/upstream/bin/wasm-opt --version > ${SDKROOT}/wasm-opt.version
        cat > ${SDKROOT}/emsdk/upstream/bin/wasm-opt <<END
#!/bin/bash
if echo \$*|grep -q version$
then
	echo "$(cat ${SDKROOT}/wasm-opt.version)"
else
	# echo "\$@" >> /tmp/wasm.opt
    exit 0
fi
END
        chmod +x ${SDKROOT}/emsdk/upstream/bin/wasm-opt
    fi
    . scripts/emsdk-extra.sh
fi


