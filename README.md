# 🧠 Personal Code Repository

> *A personal monorepo for learning, experimenting, and comparing approaches in different languages, from algorithmic challenges to scientific computing and HPC.*

This repository is a **personal monorepo** designed to host programming challenges, language learning, and scientific/high-performance computing (HPC) projects.

The main goals are:
- Maintain a **long-term scalable structure**
- Avoid unnecessary duplication of concepts
- Allow multiple languages for the same problem
- Facilitate indexing and content search

---

## 📌 Root README

This repository gathers **all my personal technical work** in one place. It is not intended as a single project, but as a **living archive of learning and experimentation**.

Here you will find:
- Programming challenges solved in **multiple languages** (Advent of Code, LeetCode, etc.)
- Notes and code written while learning **new languages and paradigms**
- Experiments in **scientific computing, parallelism, CUDA, and HPC**

The structure prioritizes:
- Conceptual clarity over organization by language
- Idea reuse
- Comparison between approaches

Not all code is "polished": many folders reflect the **real process of learning**.

---

## 📁 General Structure

```text
personal-code/
├── challenges/              # Specific problems and challenges
├── learning/                # Structured learning
├── scientific-computing/    # Scientific computing and HPC
├── tools/                   # Scripts and infrastructure
├── docs/                    # Notes, references, and indexes
└── README.md                # This file
```

Each folder contains its own `README.md` explaining its purpose and contents.

---

## 🧩 Naming Convention

### 📂 Folders

- Use **kebab-case**: `advent-of-code`, `scientific-computing`
- Avoid ambiguous abbreviations
- Prefer conceptual names over technical ones

Examples:
- ✅ `dynamic-programming`
- ❌ `dp`

---

### 📄 Files

- Use **snake_case** or the language's standard convention
- Include version or variant only if necessary

Examples:
- `quicksort_recursive.f90`
- `day05_part2.bas`

---

### 🏷 Languages

- Use full lowercase names:
  - `python`, `fortran`, `vba`, `cpp`, `cuda`

---

## 🧪 Template for New Challenges

To reduce friction and maintain consistency, challenges follow a common template.

If I automate statistics, benchmarks, or searches in the future, this structure allows it without major refactoring.

### 📁 Base Structure

```text
challenge-name/
├── README.md
├── input/
├── solutions/
│   └── <language>/
│       ├── solution.ext
│       └── notes.md
└── tags.yml
```

---

### 📄 README.md (challenge)

```md
# Challenge Name

## Source
- Platform: Advent of Code / LeetCode / Other
- Year / ID: 2025 - Day 03

## Problem Statement
Brief summary of the problem.

## Strategy
Main ideas and approach.

## Languages Used
- VBA
- Fortran
```

---

## 🧪 Advent of Code Template

```text
advent-of-code/2025/fortran/day03/
├── README.md
├── input.txt
├── part1.f90
├── part2.f90
└── notes.md
```

---

## 🧪 Language Learning Template

```text
learning/languages/fortran/
├── basics/
├── io/
├── algorithms/
├── numerical/
└── README.md
```

The language README should include:
- Reason for learning
- Resources used
- Links to shared concepts

---

## 🤖 Script to Generate Challenges Automatically

This script creates the minimal structure for a new challenge or Advent of Code day.

### Example (Bash)

```bash
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

## Approach

## Notes
EOF

touch "$BASE/input.txt"
touch "$BASE/part1.${LANG}"
touch "$BASE/part2.${LANG}"

echo "Structure created at $BASE"
```

---

## 🏷 Tag and Index System

### 📄 tags.yml (per project or challenge)

```yaml
language:
  - fortran
  - vba

domain:
  - algorithms
  - numerical-methods

techniques:
  - dynamic-programming
  - recursion

difficulty: medium
```

---

### 📚 Central Index (`docs/index.md`)

```md
# Global Index

## By Language
- [Fortran](../learning/languages/fortran)
- [Python](../learning/languages/python)

## By Domain
- [Algorithms](../learning/concepts/algorithms)
- [PDEs](../scientific-computing/numerical-analysis/pde)

## Featured Challenges
- Advent of Code 2025 (Fortran)
```

---

## 🧭 Quick Decision Rule

> **Am I solving a specific problem, learning a concept, or analyzing a method?**

- Specific problem → `challenges/`
- Learning → `learning/`
- Scientific analysis / real performance → `scientific-computing/`

---

## 🚀 Future Vision

This repository is designed to grow towards:
- Multi-language comparison
- Real benchmarks
- HPC experimentation with MPI, CUDA, and SLURM
- Reusable technical documentation

---

*Last updated: 2025*

