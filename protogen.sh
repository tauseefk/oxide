#!/bin/bash

mkdir -p ./oxide-client/app/_proto

PROTOC=`command -v protoc`
if [[ "$PROTOC" == "" ]]; then
  echo "Required "protoc" to be installed. Please visit https://github.com/protocolbuffers/protobuf/releases (3.5.0 suggested)."
  exit -1
fi

echo "Compiling protobuf definitions"
protoc \
  --plugin=protoc-gen-ts=./oxide-client/node_modules/.bin/protoc-gen-ts \
  -I ./proto \
  --js_out=import_style=commonjs,binary:./oxide-client/app/_proto \
  --ts_out=service=grpc-web:./oxide-client/app/_proto \
  ./proto/chat.proto