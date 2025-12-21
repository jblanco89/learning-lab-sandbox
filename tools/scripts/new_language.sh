#!/usr/bin/env bash

LANG=$1
BASE="learning/languages/$LANG"

mkdir -p "$BASE"/{basics,io,algorithms,numerical}

cat > "$BASE/README.md" <<EOF
# $LANG

Context and study purpose:

- personal learning
- language performance benchmark
- potential usage as HPC / scientific tool

## Basic Structure
- basics/
- io/
- algorithms/
- numerical/

EOF

cat > "$BASE/tags.yml" <<EOF
language:
  - $LANG

domain:
  - algorithms
  - data-structures
  - spreadsheet automation
  - data-analytic
  - dashboards

techniques:
  - brute-force
  - procedural-programming
  - data-tables

difficulty: 
 - medium

status: 
- in progress

EOF

echo "Language $LANG Initialized."
