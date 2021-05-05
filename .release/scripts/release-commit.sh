#!/bin/bash

source .release/releases/current/manifest.env

mvn versions:set -DnewVersion=$NEXT_PROJECT_VERSION

git add pom.xml .release/releases/current .release/releases/$NEXT_PROJECT_VERSION

git commit -m "release $NEXT_PROJECT_VERSION"
git tag $NEXT_GIT_TAG -m "release $NEXT_PROJECT_VERSION"
