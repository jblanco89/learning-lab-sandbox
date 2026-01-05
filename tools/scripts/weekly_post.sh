#!/bin/bash

WEEK="01"
PROBLEM="ways to measure level of concordance among 2 or more raters when we want to validate an assessment tool"
FOCUS="metrics like Fleiss' Kappa for categorical data"
LANG="VBA"
CONCEPT="in handling multi-rater categorical data and implementing statistical calculations maybe taking advantage of Excel's built-in functions"
KEY_IDEA="deeply understand the Fleiss' Kappa formula, its structure and properties"
BENEFIT="to get adequate measures of inter-rater reliability for assessment validations"
ADV1="automating the calculation of Fleiss' Kappa in Excel VBA for efficient data analysis"
ADV2="comparing results with other metrics such as Kendall's W, to ensure consistency and reliability"
TRADEOFF="Fleiss' Kappa may be affected by prevalence and bias issues in the data. it means that in datasets with imbalanced categories, the kappa value might not accurately reflect the true level of agreement among raters"
ALTERNATIVE="other inter-rater reliability metrics like Krippendorff's Alpha, which can handle different data types and missing data more effectively"
RESULT="a light VBA module implementation of Fleiss' Kappa"
REPO="https://github.com/jblanco89/learning-lab-sandbox/tree/main/challenges/advent-of-code/2025/vba/day08"



BASE="posts"

mkdir -p "$BASE"

cat <<EOF > "$BASE/post_$WEEK.md"


🧠 Weekly Algorithm & Systems Notes — Week #$WEEK

Sometimes, when we explore a research field, we need to consider $PROBLEM. In this case I focus on $FOCUS.

The solution is going to be implemented using $LANG, with a strong emphasis on $CONCEPT.

The key idea is to model a very common research problem by $KEY_IDEA, which made it possible to $BENEFIT.

From a technical standpoint, using this approach provided:
- $ADV1
- $ADV2

According the theory, a tradeoff to consider is $TRADEOFF, especially when compared to $ALTERNATIVE.

Overall, the solution expected $RESULT.

🔗 Resources:
$REPO

Abraira, V. (2000). "El índice kappa". SEMERGEN, volumen 27, páginas 247-249.

Fleiss, J. L., Levin, B., & Paik, M. C. (2003). "The Measurement of Interrater Agreement". Statistical Methods for Rates and Proportions, chapter 18. Wiley-Interscience.

EOF
