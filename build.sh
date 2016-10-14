#!/bin/bash -e

OPENSSL_VERSION="1.0.2j"  #Put the latest OPENSSL version
CWD=$(pwd)

virtualenv env
. env/bin/activate
pip install -U setuptools
pip install -U wheel pip
curl -O https://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz
tar xvf openssl-${OPENSSL_VERSION}.tar.gz
cd openssl-${OPENSSL_VERSION}
./config no-shared no-ssl2 -fPIC --prefix=${CWD}/openssl
make && make install
cd ..
mkdir -p wheelhouse
CFLAGS="-I${CWD}/openssl/include" LDFLAGS="-L${CWD}/openssl/lib" pip wheel --wheel-dir=wheelhouse --no-binary :all: cryptography

