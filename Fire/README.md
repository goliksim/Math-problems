# Клеточный автомат, моделирующий распростроение лесного пожара.
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

#количество источников пожара
fires = 4

#задаем случайные источники
for i in range(fires):
    x=np.random.randint(N-1)
    y=np.random.randint(N-1)
    flames = np.append(flames,[[x,y]],axis=0)
    arr[x,y]=1


print(flames)

def fire():
    global flames
    global ash

    #поиск новых областей для пожара
    new_ash=np.empty((0,2),dtype=int)
    N=len(flames)
    for i in range(0,N):
        x,y = flames[i]
        for a,b in product([x-1,x,x+1],[y-1,y,y+1]):
            if (0<=a<50) and (0<=b<50):
                if arr[a,b]==0 : 
                    arr[a,b]=1
                    flames = flames = np.append(flames,[[a,b]],axis=0)
        #массив новых угольков из старых пожаров
        new_ash=np.append(new_ash,[[x,y]],axis=0) #
        arr[x,y]=2

    #удаляем из списка пожара те, что старые
    for i in range(N):
        flames = np.delete(flames,0,0)

    #восстанавливаем травку из угольков
    for x,y in ash:
        arr[x,y]=0
    ash = new_ash.copy()

#временная функция
for counter in range(100):
    plt.ion()

    #часть визуализации
    plt.clf()
    
    ax = plt.axes(xlim=(0, N), ylim=(0, N))
    ax.set_title("Клеточный автомат лесного пожара")
    x, y = np.meshgrid(range(0,N),range(0,N))
    plt.scatter(x, y, c = np.array([col[x] for x in arr.reshape(-1)]) )
    plt.draw_all()
    plt.gcf().canvas.flush_events()
    
    time.sleep(0.5)
    plt.show()

    fire()  #вызов функции пожара

plt.ioff()
```
## Результат

<img src="https://user-images.githubusercontent.com/66952748/158303514-8fa4942a-48b0-4a8a-be2f-42c2a2ad6bb6.png" height="300"/> <img src="https://user-images.githubusercontent.com/66952748/158303521-bacb41a9-6741-4cef-8963-9ba555b7c881.png" height="300"/>
