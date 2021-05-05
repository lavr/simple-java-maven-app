#!/bin/bash
set -x
set -e

source .release/releases/current/manifest.env

git push
git push --tags
gh release create $NEXT_GIT_TAG -F .release/releases/current/changelog.md -R "$(git config --get remote.origin.url)"