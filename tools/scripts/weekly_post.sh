#!/bin/bash

WEEK=""
PROBLEM="the Advent of Code 2025 Day 07 puzzle involving tachyon beam splitting"
FOCUS="tracking and aggregating multiple beam paths and timelines through a grid"
LANG="VBA"
CONCEPT="Dictionary-based state aggregation for parallel paths"
KEY_IDEA="mapping active grid positions to the number of beams or timelines reaching them"
BENEFIT="handle exponential path splitting through accumulation instead of explicit simulation"
ADV1="constant-time access and updates for active beam states"
ADV2="natural aggregation of multiple paths converging at the same position"
TRADEOFF="higher memory usage and reliance on COM-based Scripting.Dictionary"
ALTERNATIVE="Collections or array-based simulations"
RESULT="a scalable and readable solution for both beam counting and many-worlds timeline aggregation"
REPO="https://github.com/tu_repo/aoc2025_day07"



BASE="posts"

mkdir -p "$BASE"

cat <<EOF > "$BASE/post_test_1.md" # to be adapted for weekly use later


🧠 Weekly Algorithm & Systems Notes — Week #$WEEK

A couple of weeks ago I solved $PROBLEM, focusing on $FOCUS.

The solution was implemented using $LANG, with a strong emphasis on $CONCEPT.

The key idea was to model the problem as $KEY_IDEA, which made it possible to $BENEFIT.

From a technical standpoint, using this approach provided:
- $ADV1
- $ADV2

The main tradeoff to consider is $TRADEOFF, especially when compared to $ALTERNATIVE.

Overall, the solution resulted in $RESULT.

🔗 Code & resources:
$REPO

EOF
