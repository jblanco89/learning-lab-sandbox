# Advent of Code 2025 - Day 08: Kruskal's Algorithm Visualization

## Problem Description
The challenge for Day 08 involves finding the Minimum Spanning Tree (MST) of a graph defined by a set of nodes and edges. The goal is to connect all nodes with the minimum total edge weight, ensuring no cycles are formed. This is a classic problem in graph theory, often solved using Kruskal's algorithm.

## Solution Approach

### Union-Find Data Structure
To efficiently determine whether adding an edge would create a cycle, the Union-Find (Disjoint Set Union) data structure is used. It supports two main operations:
- **Find:** Determines the root of a node, allowing us to check if two nodes are in the same component.
- **Union:** Merges two components if they are disjoint.

This structure is implemented in `UnionFindModule.bas` and tested in `UnionFindTest.bas`.

### Kruskal's Algorithm
Kruskal's algorithm is used to construct the MST:
1. Sort all edges by weight.
2. Iterate through the sorted edges, adding each edge to the MST if it connects two different components (checked using Union-Find).
3. Stop when all nodes are connected.

The implementation is found in `KruskalMod.bas` and is orchestrated by `solution.cls`.

### Data Handling and Visualization
- **Data Input:** The nodes and edges are provided in `nodes.csv` and `edges.csv`.
- **Export:** The module `ExportCSVDay8Mod.bas` handles exporting results.
- **Visualization:** The process and results are visualized using the Python script `visualization.py`, which can generate an animation of the MST construction.

## Video Demonstration
Below is an embedded gif demonstrating the Kruskal's algorithm in action on the provided graph data:

[![Kruskal's Algorithm Visualization](./visual/Day8Visualization.gif)]

---

**Files in this folder:**
- `solution.cls`: Main VBA solution orchestrating the process
- `KruskalMod.bas`: Kruskal's algorithm implementation
- `UnionFindModule.bas`: Union-Find data structure
- `UnionFindTest.bas`: Tests for Union-Find
- `ExportCSVDay8Mod.bas`: Data export module
- `visualization.py`: Python script for visualization
