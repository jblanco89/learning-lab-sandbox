#!/usr/bin/env bash

# Usage:
# ./new_challenge.sh advent-of-code 2025 day03 fortran


CHALLENGE=$1
YEAR=$2
UNIT=$3
LANG=$4


BASE="challenges/$CHALLENGE/$YEAR/$LANG/$UNIT"

mkdir -p "$BASE"

cat > "$BASE/README.md" <<EOF
# $CHALLENGE $YEAR - $UNIT

## Language
$LANG

## Purpose


## Notes


EOF


touch "$BASE/input.txt"
touch "$BASE/part1.${LANG}"
touch "$BASE/part2.${LANG}"


echo "New structure $BASE created"