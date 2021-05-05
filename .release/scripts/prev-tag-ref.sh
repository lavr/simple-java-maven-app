#!/bin/bash
set -e

#current_tag="${GITHUB_REF#refs/tags/}"
start_ref="HEAD"

# Find the previous release on the same branch, skipping prereleases if the
# current tag is a full release
previous_tag=""
while [[ -z $previous_tag  ]]; do   # || ( $previous_tag == *-* && $current_tag != *-* )
  previous_tag="$(git describe --tags "$start_ref"^ --abbrev=0)"
  start_ref="$previous_tag"
done

echo $previous_tag
