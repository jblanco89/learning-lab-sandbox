🧠 Weekly Algorithm & Systems Notes — Week #

🧠 How I learned to use VBA Dictionary Object for Advent of Code 2025

A couple of weeks ago I solved the Advent of Code 2025 Day 07 puzzle involving tachyon beam splitting, focusing on tracking and aggregating multiple beam paths and timelines through a grid.The solution was implemented using VBA, with a strong emphasis on Dictionary-based state aggregation for parallel paths.

The key idea was to model the problem as mapping active grid positions to the number of beams or timelines reaching them, which made it possible to handle exponential path splitting through accumulation while the system keeps the trace by using the key item. Using this approach provided a constant-time access and updates for active beam states.

However, the main tradeoff in this solution is higher memory usage and reliance on COM-based "Scripting.Dictionary" (only available in Windows' Systems), especially when compared to Collections or array-based simulations.

Overall, the solution resulted was scalable and readable enough for both beam counting and timeline aggregation.

🔗 Code & resources:
https://github.com/jblanco89/learning-lab-sandbox/tree/main/challenges/advent-of-code/2025/vba/day07
