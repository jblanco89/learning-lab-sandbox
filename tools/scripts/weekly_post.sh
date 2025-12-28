#!/bin/bash

WEEK=""
PROBLEM="Day 08 puzzle, which was about junction boxes for light connections"
FOCUS="finding the minimum distance to connect all boxes so that all are reachable"
LANG="VBA and python (this latter for visualization purposes)"
CONCEPT="graph theory and minimum spanning trees (using Kruskal's algorithm)"
KEY_IDEA="representing the junction boxes and their connections as a weighted undirected graph, besides setting union-find data structures with path compression"
BENEFIT="efficiently determine the optimal connections needed to ensure all boxes are reachable with minimal total distance"
ADV1="Handling of connection weights and dynamic graph updates"
ADV2="How to set user-defined data structures in VBA to encapsulate graph components"
TRADEOFF="the complexity of implementing graph algorithms in VBA"
ALTERNATIVE="Using specialized libraries in other languages as Python or R"
RESULT="a clear understanding of minimum spanning tree algorithms and their practical applications minimizing connection distances"
REPO="https://github.com/jblanco89/learning-lab-sandbox/tree/main/challenges/advent-of-code/2025/vba/day08"



BASE="posts"

mkdir -p "$BASE"

cat <<EOF > "$BASE/post_test_2.md" # to be adapted for weekly use later


🧠 Weekly Algorithm & Systems Notes — Week #$WEEK

The last AoC challenge I solved was $PROBLEM, focusing on $FOCUS.

The solution was implemented using $LANG, with a strong emphasis on $CONCEPT.

The key idea was to model the problem $KEY_IDEA, which made it possible to $BENEFIT.

From a technical standpoint, using this approach provided:
- $ADV1
- $ADV2

The main tradeoff to consider is $TRADEOFF, especially when compared to $ALTERNATIVE.

Overall, the solution resulted in $RESULT.

🔗 Code & resources:
$REPO

EOF
