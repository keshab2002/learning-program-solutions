# Exercise 7: Financial Forecasting
## Scenario: 
We have to develope a financial forecasting tool that predicts future values based on past data.

## 1.	Understand Recursive Algorithms:

**Recursion** is a programming technique where methods call iteself to solve problem by breatking it down to smaller sub-problems.

Many problems can be naturally divided into smaller, self-similar subproblems. Recursion provides a clean way to implement this approach.(Divide and concure)


## 4.	Analysis:
The recursive approach to calculating future value has a time complexity of O(n), since it makes one recursive call for each year. Additionally, each recursive call consumes stack space, resulting in a space complexity of O(n). While this method is elegant and mirrors the mathematical definition, it can lead to stack overflow or degraded performance when n (the number of years) becomes large. 

To optimize this, we can convert the recursive method to an iterative approach using a simple loop. This version maintains the same time complexity of O(n) but reduces the space complexity to O(1), as it avoids recursive calls and thus eliminates the risk of stack overflow. The iterative method is more efficient and reliable, especially for large forecasting periods.