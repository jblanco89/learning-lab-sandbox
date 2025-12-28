

🧠 Weekly Algorithm & Systems Notes — Week #

The last AoC challenge I solved was Day 08 puzzle, which was about junction boxes for light connections focusing on finding the minimum distance to connect all boxes so that all are reachable.

The solution was implemented using VBA and python (this latter for visualization purposes), with a strong emphasis on graph theory and minimum spanning trees (using Kruskal's algorithm).

The key idea was to model the problem representing the junction boxes and their connections as a weighted undirected graph, besides setting union-find data structures with path compression, which made it possible to efficiently determine the optimal connections needed to ensure all boxes are reachable with minimal total distance.

From a technical standpoint, using this approach provided:
- Handling of connection weights dinamically.
- How to set user-defined data structures in VBA to encapsulate graph components.

The main tradeoff to consider is the complexity of implementing graph algorithms in VBA, especially when compared to specialized libraries in other languages as Python or R.

Overall, the solution resulted in a clear understanding of minimum spanning tree (MST) algorithms and their practical applications minimizing connection distances.

🔗 Code & resources:
https://github.com/jblanco89/learning-lab-sandbox/tree/main/challenges/advent-of-code/2025/vba/day08

