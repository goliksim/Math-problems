# Pseudorandom number Generator (RNG) by mixing method.
(Automatic translation)
</br></br>
The mixing method uses the operations of cyclic shift of the contents of the cell to the left and to the right.
## The essence of the method

Let the initial number R0 be stored in the cell.
Cyclically shifting the contents of the cell to the left by 1/4 of the cell length, we get a new number R0*.
Similarly, by cyclically shifting the contents of cell R0 to the right by 1/4 of the cell length, we get the second number R0**.
The sum of the numbers R0* and R0** gives a new random number R1. Next, R1 is entered into R0, and the entire sequence of operations is repeated
</br></br>
![image](https://user-images.githubusercontent.com/66952748/158296228-4e52f8b8-00fe-4c5d-91ef-420397f24eec.png)
## Accounting for extra digits
The number obtained as a result of summing R0* and R0** may not fit completely in cell R1.
In this case, extra digits should be discarded from the resulting number.
Let's explain this for Figure 22.8, where all cells are represented by eight binary digits.
Let R0* = 100100012 = 14510, R0** = 101000012 = 16110, then R0* + R0** = 1001100102 = 30610.
As you can see, the number 306 occupies 9 digits (in binary notation), and cell R1 (like R0) can accommodate a maximum of 8 digits.
Therefore, before entering the value into R1, it is necessary to remove one "extra", the leftmost bit from the number 306, as a result of which not 306 will go to R1,
but 001100102 = 5010. In languages such as Pascal, the "truncation" of extra bits when a cell overflows is performed automatically
in accordance with the specified type of variable.

```python
# clearing the console of unnecessary library information
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

#number of sampling points
Iterations = 1000

#sequence generation function
def mixing(number, CountOfNumbers):
den = 2
RandomsArray = []
while len(RandomsArray) != CountOfNumbers:
R_start = str(bin(number))[2:] # remove 0b
a = int(R_start[+den:] + R_start[:+den], base = 2)
b = int(R_start[-den:] + R_start[:-den], base = 2)
number = a + b
RandomsArray.append(float("0." + str(number)[1:]))

return RandomsArray

# visual information output function
def print_bars(vector, name):
fig = plt.figure(figsize=(10,4))
plt.subplot(1,2,1)
plt.scatter(range(Iterations),vector,s=10)
plt.title(name)
plt.ylabel("Number value")
```
# My problem (Chi-square hypothesis)
The task of my work was to achieve confirmation of the chi-square hypothesis about the uniform distribution of the sequence when using this generator.
Pearson's criterion, or criterion22 (Chi-squared) - is used to test the hypothesis that the empirical distribution corresponds to the assumed theoretical
distribution F(x) with a large sample size (n ≥ 100).
The use of criterion χ2 involves dividing the range of variation of the sample into intervals and determining the number of observations (frequency) for each of the intervals.
In my case, the check is for a uniform distribution of the sequence of generated numbers by mixing. Numbers can take values from 0 to 1.
In the program, I use splitting the interval into segments of width 0.1, their frequency and counting.
### Criterion statistics
![image](https://user-images.githubusercontent.com/66952748/158297998-dbeac7fb-26f1-45b9-b95c-8a7c1d341dc5.png )
### Criterion rule
If the obtained statistics exceeds the quantile of the distribution law χ2 of a given significance level α with (k - 1) or with (k - p - 1) degrees of freedom,
where k is the number of observations or the number of intervals (for the case of an interval variation series), and p is the number of estimated parameters of the distribution law,
then the hypothesis H0 is rejected. Otherwise, the hypothesis is accepted at a given level of significance α.
</br>
In my case, the number of degrees of freedom k=10-1=9.
```python

sorted_vector = sorted(vector)
plt.subplot(1,2,2)
sns.distplot(sorted_vector)

plt.title(name)
plt.xlabel("Split interval")
plt.ylabel("Probability of hitting the interval")
plt.tight_layout()
plt.show()

# checking Pearson's consent criterion
def xi_2_proof(vector, bins=10):

xi_2 = 0
for i in np.linspace(0.1, 1, bins):
xi_2 += (sum((vector > i-0.1) & (vector < i)) - Iterations/bins)**2 / (Iterations/bins)


xi_2_5 = 16.9 # for 10-1 = 9 degree of freedom
xi_2_95 = 3.33

if (xi_2 > xi_2_95 and xi_2 < xi_2_5):
print("H0")
else:
print("H1")
return xi_2
```
The main function of the script
```python
if __name__ == "__main__":

#Iterations= 1000 # 7553 - initial number (generation LED), selected by iterative method

vec_mix_method = np.array(mixing(7001, Iterations))

vec_mix_method = (vec_mix_method - np.min(vec_mix_method))/(np.max(vec_mix_method)-np.min(vec_mix_method))
# normalized the sample by lowering the chi-squared statistics,

bins = 10 # number of splits from 0 to 1
xi_2 = xi_2_proof(vec_mix_method, bins)

print(f"Chi-squared statistics: {xi_2:.2f}")
print("Number of different numbers:",len(set(vec_mix_method))) # all numbers are different, so the period is at least more than 1000
print_bars(vec_mix_method, "Mixing Method")

```
Hypetesis H0 is accepted at a significance level of 0.95.
</br></br>
![image](https://user-images.githubusercontent.com/66952748/158296199-499ab7be-da12-4622-8f88-01d401bbe43a.png)
### Consistency Table:
![image](https://user-images.githubusercontent.com/66952748/158299710-b6a089f6-f244-42e3-a3ba-6d2a083f20f5.png)
</br>
Thanks for your attention!
