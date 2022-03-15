# A cellular automaton simulating the spread of a forest fire.
```python
import time
import numpy as np
import matplotlib.pyplot as plt
from itertools import product

N = 50
arr = np.zeros((N,N),dtype=int)
col = { 0:'#5E874E',
1: '#EEB145',
2:'#715D3B'}

flames = np.empty((0,2),dtype=int)
ash = np.empty((0,2),dtype=int)

#number of fire sources
fires = 4

#setting random sources
for i in range(fires):
x=np.random.randint(N-1)
y=np.random.randint(N-1)
flames = np.append(flames,[[x,y]],axis=0)
arr[x,y]=1


print(flames)

def fire():
global flames
global ash

#search for new areas for fire
new_ash=np.empty((0,2),dtype=int)
N=len(flames)
for i in range(0,N):
x,y = flames[i]
for a,b in product([x-1,x,x+1],[y-1,y,y+1]):
if (0<=a<50) and (0<=b<50):
if arr[a,b]==0 :
arr[a,b]=1
flames = flames = np.append(flames,[[a,b]],axis=0)
#array of new embers from old fires
new_ash=np.append(new_ash,[[x,y]],axis=0) #
arr[x,y]=2

#removing the old ones from the fire list
for i in range(N):
flames = np.delete(flames,0,0)

#restoring grass from embers
for x,y in ash:
arr[x,y]=0
ash = new_ash.copy()

#temporary function
for counter in range(100):
plt.ion()

#visualization part
of the plt.clf visualization()

ax = plt.axes(xlim=(0,N), ylim=(0, N))
ax.set_title("Forest fire cellular automaton")
x, y = np.meshgrid(range(0,N),range(0,N))
plt.scatter(x, y, c = np.array([col[x] for x in arr.reshape(-1)]) )
plt.draw_all()
plt.gcf().canvas.flush_events()

time.sleep(0.5)
plt.show()

fire() #calling the fire function

plt.ioff()
```
## Result

<img src="https://user-images.githubusercontent.com/66952748/158303514-8fa4942a-48b0-4a8a-be2f-42c2a2ad6bb6.png" height="300"/> <img src="https://user-images.githubusercontent.com/66952748/158303521-bacb41a9-6741-4cef-8963-9ba555b7c881.png" height="300"/>
