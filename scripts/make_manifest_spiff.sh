#!/bin/bash

set -ex

. "$(dirname "$0")/setenv"

STUB=${STUB:-$1}
DIRECTOR_UUID=${DIRECTOR_UUID:-$(bosh status --uuid)}

shift 1 || true

if [[ -z $STUB ]]; then
    echo "Usage: $0 manifest_stub_path <deployment> [manifest-file]"
    exit 1
fi

echo "Working directory: $(pwd)"

STUB_NAME=`basename $STUB`
MANIFEST_FILE=${PWD}/tmp/$STUB_NAME

echo "Writing manifest to ${MANIFEST_FILE}"

output_dir=$(dirname ${MANIFEST_FILE})
mkdir -p $output_dir

spiff merge $RELEASE_DIR/templates/geode.yml $STUB "$@" > $MANIFEST_FILE

echo "Director UUID: $DIRECTOR_UUID"
perl -pi -e "s/PLACEHOLDER-DIRECTOR-UUID/$DIRECTOR_UUID/g" $MANIFEST_FILE

if [[ "${BOSH_ENV}" != "concourse" ]]; then
    echo "Setting manifest file to $MANIFEST_FILE..."
    bosh deployment $MANIFEST_FILE
fi
