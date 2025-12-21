# 🧠 Personal Code Repository

## 📓 Reproducible Scientific Experiment Template

This template is designed for **numerical experiments, HPC, and scientific computing** where reproducibility is essential.

Template aims to:
- Repeat the experiment months later
- Compare variants (language, parallelism, hardware)
- Understand which decision affected which result

---

### 📁 Structure

```text
experiment-name/
├── README.md            # Main scientific document
├── tags.yml             # Experiment metadata
├── src/                 # Source code
├── input/               # Input data / initial conditions
├── config/              # Experiment parameters
├── results/             # Numerical outputs
├── plots/               # Generated plots
└── notes.md             # Free-form observations
```

---

### 📄 tags.yml (experiment)

```yaml
language:
  - fortran

domain:
  - scientific-computing
  - numerical-methods

topic:
  - pde
  - heat-equation

techniques:
  - finite-difference
  - openmp

hardware:
  - cpu

status: experimental
```

---

## 🧠 Conventions for Scientific READMEs

The `README.md` **is the informal paper of the experiment**. It should be readable without opening the code.

### 🧪 Required Structure

```md
# Experiment Name

## 1. Objective
What do I want to study or measure?

## 2. Context
Why this problem is interesting or relevant.

## 3. Mathematical Model
Equations, hypotheses, and simplifications.

## 4. Numerical Method
- Discretization
- Scheme
- Order of convergence (if applicable)

## 5. Implementation
- Language
- Parallelization
- Libraries

## 6. Experiment Configuration
- Domain size
- Time/space step
- Physical parameters

## 7. Results
- Qualitative observations
- Metrics
- Tables / plots

## 8. Analysis
Interpretation of results.

## 9. Limitations
What is not being modeled or measured.

## 10. Future Work
Clear ideas to extend the experiment.
```

---

### 🧭 Important Rules

- **No results without context**
- Clearly separate:
  - *what I wanted to test*
  - *what I did*
  - *what happened*
- If a result is surprising, document it

---

## 🧪 Minimal Example (excerpt)

```md
## 1. Objective
Evaluate the stability of the explicit scheme for the 1D heat equation.

## 4. Numerical Method
Centered finite differences in space and explicit Euler in time.

## 7. Results
Numerical instability is observed when dt > dx^2 / 2.
```

---

## 🧠 Philosophy

This approach treats the repository as:
- A lab notebook
- A record of technical decisions
- A basis for future comparisons

The priority is not perfection, but **traceability**.

---

*Last updated: 2025*

