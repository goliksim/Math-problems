Dynamo Rikitake

Dynamo Rikitake is one of the well-known dynamical systems of the third order with chaotic behavior.
It is a model of a two-disc dynamo and was first proposed in problems of chaotic inversion of the Earth's geomagnetic field.
In a dynamo with two interconnected disks, the current from one coil of the disk flows into the other and excites the second
disk, and vice versa.
At a certain point, the system starts to crash and show unpredictable behavior.

The standard (simple) Ricky model still does not take into account friction. It is described by the following system of equations:

x' = yz-𝜇x   
y'=x(z-a)-𝜇y  
z'=1-xy


The method for implementing the construction of a phase portrait of this system is presented in the Rikitaki.m file
```matlab
clc
t_interval = [0 1000];
Start_cond = [0.3; 0.3; 0.3];

% With the parameters 𝜇 = 0.498, 𝑎 = 0.1 
u = 0.498;
a = 0.1;

[t, X] = ode45(@(t,X) pendulum_n(t,X,u,a), t_interval, Start_cond );
plot3(X(:,1),X(:,2),X(:,3))
hold off

% we get a graph where both the saddle and the spiral focus are visible

function dXdt = pendulum_n(t,X,u,a)
    dx = -1*u*X(1)+X(2)*X(3);
    dy = X(1)*(X(3)-a)-u*X(2);
    dz = 1 - X(1)*X(2);
    dXdt = [dx;dy;dz];
end
```

<a href="url"><img src="https://habrastorage.org/r/w1560/files/49f/e2a/2c0/49fe2a2c04824274b0617413c246c62e.png" align="right" width="220" height="220"></a>

The standard Riki system still has an integral of motion (
the difference in the angular velocities of the disks is preserved). This leads to the fact that different values
of the integral of motion correspond to different steady-state motions, which is incomprehensible
from a physical point of view.

This model is used to study the relationship between large
vortices of magnetic fields in the Earth's core and the chaotic inversion of the Earth's geomagnetic field.
These are considered as an imitation of two large vortices in the Earth's core.

Literature:

Нелинейная механика. Часть2. Беркман<br />
Решение систем Д/У: 1. Знакомство с функциями odeXY. MATLABinRussia<br />
https://www.youtube.com/watch?v=QXXZ0KwZICo&ab_channel=MATLABinRussia<br />
Вячеслав Овдий. Метод фазовой плоскости при анализе 
динамических систем в MATLAB<br />
https://a-lab.ee/edu/sites/default/files/Vjatseslav_Ovdi_bak_diplomitoo.pdf<br />
Использование MATLAB. Решение дифференциальных уравнений.
Доля П.Г. Харьковский Национальный Университет<br />
http://geometry.karazin.ua/resources/documents/20140425101544_ca2b78ee.pdf
