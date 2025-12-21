#!/usr/bin/env bash

# Usage:
# ./new_experiment.sh <domain> <experiment-name>
#
# Example:
# ./new_experiment.sh interpolation runge-function

set -e

DOMAIN=$1
NAME=$2

if [ -z "$DOMAIN" ] || [ -z "$NAME" ]; then
  echo "Usage: $0 <domain> <experiment-name>"
  exit 1
fi

BASE="scientific-computing/numerical-analysis/$DOMAIN/$NAME"

echo "Setting new experiment in:"
echo "  $BASE"

# Base structure
mkdir -p "$BASE"/{src,input,config,plots,results/{raw,processed,summary},analysis}

# Scientific README
cat > "$BASE/README.md" <<EOF
# $NAME

## 1. Purpose
Clearly describe what is to be studied or compared.

## 2. Context
Why this problem is relevant or interesting.

## 3. Math Model
Definition of the mathematical problem.

## 4. Methods to be compared
- Method A
- Method B

## 5. Implementation
Languages, technical decisions, parallel processes.

## 6. Experiment configuration
Parameters, domain, discretization.

## 7. Results
Summary of obtained results.

## 8. Analysis
Interpretation of the results.

## 9. Limitations
Assumptions and restrictions.

## 10. Prospective
Clear ideas to extend the experiment.

EOF

# tags.yml
cat > "$BASE/tags.yml" <<EOF
domain:
  - numerical-methods

topic:
  - $DOMAIN

status: experimental
EOF

# Technical decisions
cat > "$BASE/decisions.md" <<EOF
# Technical decisions

Record important decisions here, especially those that did not work.

## Example
### Decision
Use X instead of Y.

### Context
Reason for the decision.

### Result
What actually happened.

### Conclusion
Lesson learned.
EOF

# Notes
cat > "$BASE/notes.md" <<EOF
Free-form notes, ideas, quick observations.
EOF

# Analysis scripts
cat > "$BASE/analysis/metrics.py" <<EOF
# Numerical metrics
# Example: L2 error, maximum error, etc.
EOF

cat > "$BASE/analysis/analyze.py" <<EOF
# Aggregation and post-processing of results
EOF

cat > "$BASE/analysis/plots.py" <<EOF
# Plot generation from processed data
EOF

echo "Experiment '$NAME' succesfully created."
