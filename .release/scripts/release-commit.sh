#!/bin/bash

source .release/releases/current/manifest.env

git add pom.xml .release/releases/current .release/releases/$NEXT_PROJECT_VERSION