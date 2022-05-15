#/bin/bash

if ! command -v curl &> /dev/null; then
    echo "curl could not be found"
    exit 1
fi

if ! command -v tar &> /dev/null; then
    echo "curl could not be found"
    exit 1
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

pushd /tmp
curl https://blob.dolansoft.org/soicode/compilerbundle-linux-amd64-soiheaders.tar.xz -o soiheaders.tar.xz
mkdir $SCRIPT_DIR/soiheaders
tar -xvf soiheaders.tar.xz --directory $SCRIPT_DIR/soiheaders
popd
