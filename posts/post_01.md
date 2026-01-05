

🧠 Weekly Algorithm & Systems Notes — Week #01

Sometimes, when we explore a research field, we need to consider ways to measure level of concordance among 2 or more raters when we want to validate an assessment tool. In this case I focus on metrics like Fleiss' Kappa for categorical data.

The solution is going to be implemented using VBA, with a strong emphasis on in handling multi-rater categorical data and implementing statistical calculations maybe taking advantage of Excel's built-in functions.

The key idea is to model a very common research problem by deeply understand the Fleiss' Kappa formula, its structure and properties, which made it possible to to get adequate measures of inter-rater reliability for assessment validations.

To use this approach will provide:
- automating the calculation of Fleiss' Kappa in Excel VBA for efficient data analysis
- comparing results with other metrics such as Kendall's W, to ensure consistency and reliability

According the theory, a tradeoff to consider is that Fleiss' Kappa may be affected by prevalence and bias issues in the data. It means that in datasets with imbalanced categories, the kappa value might not accurately reflect the true level of agreement among raters, especially when compared to other inter-rater reliability metrics like Krippendorff's Alpha, which can handle different data types and missing data more effectively.

Overall, the solution expected a light VBA module implementation of Fleiss' Kappa.

🔗 Resources:
https://github.com/jblanco89/learning-lab-sandbox/tree/main/learning/languages/vba/numerical/fleiss_kappa

Abraira, V. (2000). "El índice kappa". SEMERGEN, volumen 27, páginas 247-249.

Fleiss, J. L., Levin, B., & Paik, M. C. (2003). "The Measurement of Interrater Agreement". Statistical Methods for Rates and Proportions, chapter 18. Wiley-Interscience.

