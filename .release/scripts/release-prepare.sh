#!/bin/bash
set -x
set -e

while getopts v: flag
do
    case "${flag}" in
        v) next_version=${OPTARG};;
    esac
done

CURRENT_PROJECT_VERSION=$(mvn help:evaluate -Dexpression=project.version -q -DforceStdout)

if [ -z $next_version ]; then
  NEXT_PROJECT_VERSION=$(python .release/scripts/bump-version.py --current-version=$CURRENT_PROJECT_VERSION --suffixes=-SNAPSHOT)
else
  NEXT_PROJECT_VERSION=$next_version
fi
echo $NEXT_PROJECT_VERSION

GIT_TAG_SUFFIX=$(date +%Y.%m.%d)
GIT_TAG_HASH=$(git rev-parse --short HEAD)
NEXT_GIT_TAG="$NEXT_PROJECT_VERSION-$GIT_TAG_SUFFIX-$GIT_TAG_HASH"

PREV_TAG_REF=$(.release/scripts/prev-tag-ref.sh)

RELEASE_DIR=.release/releases/${NEXT_PROJECT_VERSION}

mkdir -p $RELEASE_DIR
rm -f .release/releases/current
ln -s ${NEXT_PROJECT_VERSION} .release/releases/current

echo "PREV_TAG_REF=$PREV_TAG_REF
NEXT_GIT_TAG=$NEXT_GIT_TAG
CURRENT_PROJECT_VERSION=$CURRENT_PROJECT_VERSION
NEXT_PROJECT_VERSION=$NEXT_PROJECT_VERSION" > $RELEASE_DIR/manifest.env

git log "$PREV_TAG_REF".. --reverse --format="* %s (%an)" > $RELEASE_DIR/changelog.md
