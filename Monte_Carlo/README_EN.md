# Dependence of magnetization on temperature in the Ising model on a square lattice. Monte Carlo method, metropolis algorithm.
## Ising model
(Automatic translation)
</br></br>
In statistical mechanics, the two-dimensional square lattice Ising model is a simple lattice model of interacting magnetic spins.
In simple words, it is a square lattice (grid) with spins arranged in random order.
## Monte Carlo Method
The process is described by a mathematical model using a random variable generator, the model is repeatedly calculated,
based on the data obtained, the probabilistic characteristics of the process under consideration are calculated. For example, to find out by the Monte Carlo method,
what is the average distance between two random points in a circle, you need to take the coordinates of a large number of random pairs of points within the boundaries
of a given circle, calculate the distance for each pair, and then calculate the arithmetic mean for them.
</br>
In total, 2N states are possible, and with a sufficiently large number of N spins, it is difficult to obtain numerical results.
For example, when N =10, we get 210 states that are not so easy to model directly, so a statistical approach is used for modeling.
</br>
In this approach, the system is considered in a state of thermodynamic equilibrium at a certain temperature T.
During the exchange of energy with the environment, the energy will change near the equilibrium state, and the average energy of one particle is proportional to T. The implementation of a constant random change around the equilibrium state uses the Monte Carlo method and the simulation can be divided into stages:
</br>
* Play out the ai states of the system (for example, randomly) at a fixed T;
* Calculate for these states thermodynamic characteristics near equilibrium (energy E, magnetization M);
* Average the received values
## Metropolis algorithm
In the problems of statistical mechanics, the expressions "Monte Carlo method" and "Metropolis sampling method" are almost synonymous.
Here is the most general form of the Metropolis algorithm using the example of a system of spins or particles:
* Forming the initial configuration.
* We make a random trial change in the initial configuration. For example, we randomly select some spin and try to overturn it. Or we choose a random particle and try to move it to a random distance.
* We calculateЕE, that is, the change in the energy of the system caused by the test configuration change.
* IfЕE is less than or equal to zero, then we accept the new configuration and proceed to step 8.
* If ∆E is positive, we calculate the "transition probability":</br>
![image](https://user-images.githubusercontent.com/66952748/158302610-991ff0b4-8115-41b2-9a6e-740cb16f07b5.png )
* Generate a random number rnd in the interval (0, 1)
* If rnd ≤ W, then we accept the new configuration, otherwise we save the previous configuration.
* We determine the values of the required physical quantities.
* Repeat steps 2-8 to obtain a sufficient number of configurations or "tests".
* Calculate averages for configurations that are statistically independent of each other.


```python
from matplotlib import pyplot as plt
import numpy as np

t=0
J=1
n=10 # grid 10*10
A = np.zeros((n,n),dtype=int)
M = []
f = []
for T in np.linspace(0.1,5,50): # temperature change from 0 to 5
beta = 1/T
# Form the initial configuration.
A[0::2,::]= 1 #np.array([1 if x>0.5 else -1 for x in np.random.rand(50)]).reshape((n//2,n))
A[::,0::2]= 1 #np.array([1 if x>0.5 else -1 for x in np.random.rand(50)]).reshape((n,n//2))

M.append(0)
f.append(0)

for it in range (1,100,000): #number of random cell checks
i=1
j=1
while (((i%2)!= 0) or ((j%2) != 0)): # setting a random cell
i=np.random.randint(n)
j=np.random.randint(n)
E1 = 0

#print(i,j, "A = ", A[i,j])
#Calculate dE, that is, the change in the energy of the system caused by the test configuration change.

if (j-1)>=0 : #left
E1+=J*(A[i,j]*A[i,j-1])
if (i+1)<=n-1 : #lower
E1+=J*(A[i,j]*A[i+1,j])
if (j+1)<=n-1 : #upper
E1+=J*(A[i,j]*A[i,j+1])
if (i-1)>=0 : #right
E1+=J*(A[i,j]*A[i-1,j])

dE = 2*E1 # since the changes are paired

# If dE is less than or equal to zero, then we accept a new configuration (in our case, we flip the spin)
if dE < 0:
A[i,j] = -1*A[i,j]

# Metropolis algorithm
# If dE is positive, calculate the "transition probability":
elif np.exp(-1*dE*beta)>np.random.rand(): # Generate a random number rnd in the interval (0, 1)
A[i,j] *= -1*A[i,j] # If rnd≤W, then we accept the new configuration

if(it>90000):
M[t] += np.sum(A)/75 #magnetization as sum of spins/per number of cells

# We calculate averages for configurations that are statistically independent of each other.

M[t] = M[t]/10000 #average magnetization over the last 10000 steps
f[t] = T
t=t+1

plt.plot(f,M)
plt.title('Temperature dependence of magnetization')
plt.xlabel('T')
plt.ylabel('M')
plt.show()
```
## Results:
![image](https://user-images.githubusercontent.com/66952748/158302708-1852d223-e566-42e3-ba9a-333c458f8c2a.png)
