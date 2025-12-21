#!/usr/bin/env bash

DOMAIN=$1       # pde, ode, optimization
METHOD=$2       # finite-difference, finite-element
NAME=$3         # heat-equation

BASE="scientific-computing/numerical-analysis/$DOMAIN/$METHOD"

mkdir -p "$BASE"

cat > "$BASE/README.md" <<EOF
# $NAME

## Domain
$DOMAIN

## Method
$METHOD

## Purpose
Experimental description

EOF

cat > "$BASE/tags.yml" <<EOF
domain:
  - numerical-methods

topic:
  - $DOMAIN

techniques:
  - $METHOD

status: exploratory
EOF

echo "Method $NAME created."
