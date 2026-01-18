#!/bin/bash

WEEK="03"
PROBLEM="Fleiss' Kappa experimentation"
FOCUS="implementation that simulates inter-rater reliability calculations"
LANG="VBA - Excel"
CONCEPT="evaluate kappa behavior with different subjects of data, raters but keeping the same categories"
KEY_IDEA="deeply understand the Fleiss' Kappa formula, its structure and properties and how this improve as the simulation progresses"
BENEFIT="increasing the number of raters and subjects in each iteration. Raters are spread randomly across categories, simulating real-world scenarios"
ADV1="Fleiss' Kappa shows that as the number of raters and subjects increases, the concordance becomes more accurate".
ADV2="Notice how the Z-score stabilizes, showing impressive statistical significance at a 95% confidence level"
TRADEOFF="Kappa is used specifically for categorical values (nominal or ordinal). In contrast, other reliability metrics like Intraclass Correlation Coefficient (ICC) are better suited for continuous data."
ALTERNATIVE="other inter-rater reliability metrics like Krippendorff's Alpha, which can handle different data types and missing data more effectively"
RESULT="a didactic VBA module simulation of Fleiss' Kappa"
REPO="https://github.com/jblanco89/learning-lab-sandbox/learning/languages/vba/numerical/fleiss_kappa"



BASE="posts"

mkdir -p "$BASE"

cat <<EOF > "$BASE/post_$WEEK.md"


🧠 Weekly Algorithm & Systems Notes — Week #$WEEK

Evaluating agreement among researchers using the same instrument can be biased if we ignore the influence of randomness. 
Fortunately, statisticians developed methods to distinguish between decisions made by chance and those that were not.

Kappa metrics, such as Cohen's and Fleiss', allow us to evaluate concordance among two or more raters across several subjects without worrying about chance agreement. 

Continuing with $PROBLEM. In this case I focus on $FOCUS.

It was implemented using $LANG, with a strong emphasis on $CONCEPT.

The key idea is to model a very common research problem by $KEY_IDEA, which made it possible by $BENEFIT.

From a technical standpoint, using this approach provided:
- $ADV1
- $ADV2

According this simulation, a tradeoff to consider is $TRADEOFF, especially when compared to $ALTERNATIVE.

Overall, the solution expected $RESULT.

🔗 Resources:
$REPO

Abraira, V. (2000). "El índice kappa". SEMERGEN, volumen 27, páginas 247-249.

Fleiss, J. L., Levin, B., & Paik, M. C. (2003). "The Measurement of Interrater Agreement". Statistical Methods for Rates and Proportions, chapter 18. Wiley-Interscience.

EOF
