## Exercise 2: E-commerce Platform Search Function
### Scenario
We are working on the search functionality of an e-commerce platform. The search needs to be optimized for fast performance.

### 1. Understand Asymptotic Notation
Asymptotic notations are mathematical tools used to measure the performance of an algorithm.
There are three types of asymptotic notations:

- Big O Notation
- Theta Notation
- Omega Notation

#### Big O Notation:

Represents the upper bound of the execution time of an algorithm.

Hence, it is used to represent the worst-case complexity.

If f(n) denotes the execution time of a program, then:
O(g(n)) = { f(n): there exist positive constants c and n₀ such that 0 ≤ f(n) ≤ c·g(n) for all n ≥ n₀ }

#### For linear search:

- Best case: O(1)
- Average case: O(n)
- Worst case: O(n)

#### For binary search:

- Best case: O(1)
- Average case: O(log n)
- Worst case: O(log n)
 

### 4. Analysis
Linear Search takes O(n) time complexity, but Binary Search requires O(log n) time complexity.
However, in the case of an unordered collection, we cannot implement Binary Search.

Since we can sort products based on product ID, Binary Search is better.