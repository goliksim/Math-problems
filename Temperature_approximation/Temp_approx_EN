<b>The task of approximating the temperature indicators of 20 meteorological stations.</b>

There are 20 meteorological stations measuring the temperature, it is necessary
to approximate the measurement results on a two-dimensional grid of the region. Use
the following function.

<a href="url"><img src="https://github.com/goliksim/Matlab/blob/master/Temperature_approximation/apprx_img_3.png?raw=true"  text-align="middle" width="250" ></a>

where rL(x,y) is the distance from the point (x,y) to the L weather station, TL is the temperature value at the L-
th station, C(x,y) is the normalization multiplier, the closer the point (x,y) is to the station, the
more weight the corresponding term TL is taken

<img src="https://github.com/goliksim/Matlab/blob/master/Temperature_approximation/apprx_img_4.png?raw=true"  text-align="middle" width="200" >

Display the resulting temperature field on the graph. Set the temperature values and
station coordinates in a text file.
Create your own function that takes the file name, the grid step and returns
the grid [X Y] and a two-dimensional array of temperature values at the nodes of this grid.

To begin with , we will create .a txt file with the temperature values of each station and its coordinates.<br>
<b>File Stations_create.m</b>
```matlab
% The function creates initial data for a task with stations

T= zeros(20,3);                         % setting an empty matrix 20 3
T(:,1)=(-30 + int8((70)*rand(20,1)));   % the first column is the temperature values (-30:40) degrees
T(:,2)=(0 + int8((20)*rand(20,1)));     % the second and third pillars are the coordinates of x and y
T(:,3)=(0 + int8((20)*rand(20,1)))
formatSpec = '%d %d %d\n';
stations = fopen('stations.txt','w');   % opening the file
fprintf(stations, formatSpec, T');      % writing an array
fclose(stations);                       



% let's display the data for understanding
Z=zeros(20,20);
for i = 1:20
    x=1+T(i,2);
    y=1+T(i,3);
    Z(x,y)=T(i,1);
end
b = bar3(Z);
xlabel('x');
ylabel('y');
```

<img src="https://github.com/goliksim/Matlab/blob/master/Temperature_approximation/apprx_img_1.png?raw=true"  text-align="middle" width="300" >

Now let's write an approximation function that takes parameters: file name, grid step.<br>
<b>File Approximate.m</b>
"'matlab
% % data approximation function on a grid
% outputs the result as a graph, as well as an array of values to the console

function Aproximate(name, step)
    A = load(name)                       % loading an array with initial temperatures
    Size = max(max(A(:,2)),max(A(:,3))); % calculate the grid size (max X or Y)
    ScaledSize = Size/step;              % because of the grid step, the array will be larger
    T=zeros(ScaledSize,ScaledSize);      % array for grid
    onPick=0;                            % at the station points C will be = inf, so this needs to be handled separately
    for x = 1:ScaledSize
        for y = 1:ScaledSize
            C=0;
            Tl=0;
            for i = 1:20
                C=(1./((x-A(i,2)./step).^2+(y-A(i,3)./step).^2))+C;                 % we calculate the sum of C for the point x y
                if isinf(C)                 % if = inf , then we assign the station temperature value to the point
                    i
                    T(x,y)=A(i,1);
                    onPick=1;
                    break
                end
                Tl=Tl+(A(i,1)/((x-A(i,2)./step).^2+(y-A(i,3)./step).^2));           % we calculate the sum Tl for the point x y
            end
            
            if (onPick == 0)                % if not at the peak, then calculate the final temperature value in x y
                T(x,y)=Tl/C;
            end
            onPick=0;
        end
    end
    
    [X,Y] = meshgrid(1:ScaledSize); % setting the grid dimensions
    b = surf(X*step,Y*step,T);      % we build a grid and scale back the coordinate signatures
    b.EdgeColor = 'none';           % removing the edges of the grid
    xlabel('x')                     % axis signatures
    ylabel('y')
    
    % it is also possible to display data in the form of a chart
    %b = bar3(T);
    %for k = 1:length(b)
    %    zdata = b(k).ZData;
    %    b(k).CData = zdata;
    %    b(k).FaceColor = 'interp';
    %end
    T
end
```
And finally the startup file.<br>
<b>Filr Task2.m</b>
```matlab
% we call the approximation function and pass it the name of the data file and the grid step
Aproximate("stations.txt",0.125)
% here "stations.txt" - the name of the file with the source data that was created by the function Stations_create
% 0.25 - grid pitch
%the initial data is created in increments of 1 within 20 by x and y
% a step of 0.25 will increase the final array by 4 times (the graph will be smoother)
```
<img src="https://github.com/goliksim/Matlab/blob/master/Temperature_approximation/apprx_img_2.png?raw=true"  text-align="middle" width="300" >
That's it.
