%������� 4 - ����� �.�.
% ����������� ������� 
% x' = yz-?x   
% y'=x(z-a)-?y  
% z'=1-xy
clc

t_interval = [0 1000];
Start_cond = [0.3; 0.3; 0.3];



% ��� ���������� ? = 0.1, ? = 0.6
u = 0.1;
a = 0.6;

[t, X] = ode45(@(t,X) pendulum_n(t,X,u,a), t_interval, Start_cond );
plot3(X(:,1),X(:,2),X(:,3));
hold on
% �������� ���������� ���������� �����
% ���������� � ����������� ��������� XY

% ��� ���������� ? >= 1, ? = 0.9
u = 2;
a = 0.9;

[t, X] = ode45(@(t,X) pendulum_n(t,X,u,a), t_interval, Start_cond );
plot3(X(:,1),X(:,2),X(:,3));
hold on
% �������� �����

% ��� ���������� ? = 0.498, ? = 0.1 
u = 0.498;
a = 0.1;

[t, X] = ode45(@(t,X) pendulum_n(t,X,u,a), t_interval, Start_cond );
plot3(X(:,1),X(:,2),X(:,3))
hold off
% �������� ������, ��� ����� � ����� � ���������� �����

function dXdt = pendulum_n(t,X,u,a)
    dx = -1*u*X(1)+X(2)*X(3);
    dy = X(1)*(X(3)-a)-u*X(2);
    dz = 1 - X(1)*X(2);
    dXdt = [dx;dy;dz];
end