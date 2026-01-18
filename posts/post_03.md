

🧠 Weekly Algorithm & Systems Notes — Week #03

# 🤝 Understanding Agreement: Simulating Fleiss' Kappa in Excel VBA 🖳

<strong>Is it Agreement or Just Luck?</strong> Evaluating agreement among researchers using the same instrument can be biased if we ignore the influence of randomness. Fortunately, statisticians have developed methods to distinguish between decisions made by chance and those that are not.

Kappa metrics, such as Cohen's and Fleiss', allow us to evaluate concordance among two or more raters across several subjects, accounting for chance agreement.

Continuing with Fleiss' Kappa experimentation, I focused on implementing a simulation of inter-rater reliability calculations using VBA in Excel. The emphasis was on observing kappa behavior with varying numbers of subjects and raters, while keeping the same categories.

The key idea is to model a common research problem by deeply understanding the Fleiss' Kappa formula—its structure, properties, and how reliability improves as the simulation progresses. By increasing the number of raters and subjects in each iteration, and randomly assigning raters to categories, the simulation reflects real-world scenarios.

From a technical standpoint, this approach showed:
- Fleiss' Kappa becomes more accurate as the number of raters and subjects increases.
- The Z-score stabilizes, indicating strong statistical significance at a 95% confidence level.

A tradeoff to consider is that Kappa is specifically designed for categorical values (nominal or ordinal). In contrast, metrics like the Intraclass Correlation Coefficient (ICC) are better suited for continuous data, while Krippendorff's Alpha can handle different data types and missing data more effectively.

Overall, the solution provides a didactic VBA module simulating Fleiss' Kappa.

🔗 Resources:
https://github.com/jblanco89/learning-lab-sandbox/tree/main/learning/languages/vba/numerical/fleiss_kappa

Abraira, V. (2000). "El índice kappa". SEMERGEN, volumen 27, páginas 247-249.

Fleiss, J. L., Levin, B., & Paik, M. C. (2003). "The Measurement of Interrater Agreement". Statistical Methods for Rates and Proportions, chapter 18. Wiley-Interscience.

