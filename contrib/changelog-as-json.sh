#!/bin/bash
set -e

current_tag="${GITHUB_REF#refs/tags/}"
start_ref="HEAD"

# Find the previous release on the same branch, skipping prereleases if the
# current tag is a full release
previous_tag=""
while [[ -z $previous_tag  ]]; do   # || ( $previous_tag == *-* && $current_tag != *-* )
  previous_tag="$(git describe --tags "$start_ref"^ --abbrev=0)"
  start_ref="$previous_tag"
done

git log "$previous_tag".. --pretty=format:'{%n  "commit": "%H",%n  "abbreviated_commit": "%h",%n  "tree": "%T",%n  "abbreviated_tree": "%t",%n  "parent": "%P",%n  "abbreviated_parent": "%p",%n  "refs": "%D",%n  "encoding": "%e",%n  "subject": "%s",%n  "sanitized_subject_line": "%f",%n  "body": "%b",%n  "commit_notes": "%N",%n  "verification_flag": "%G?",%n  "signer": "%GS",%n  "signer_key": "%GK",%n  "author": {%n    "name": "%aN",%n    "email": "%aE",%n    "date": "%aD"%n  },%n  "commiter": {%n    "name": "%cN",%n    "email": "%cE",%n    "date": "%cD"%n  }%n},' | sed "$ s/,$//" | sed ':a;N;$!ba;s/\r\n\([^{]\)/\\n\1/g'| awk 'BEGIN { print("[") } { print($0) } END { print("]") }'
