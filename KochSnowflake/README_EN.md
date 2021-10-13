# Introduction
A program for creating a MATLAB package of Koch snowflakes, also known as the Koch fractal

The Koch curve is a fractal curve described in 1904 by the Swedish mathematician Helge von Koch.

## Koch's Snowflake
Three copies of the Koch curve, constructed (with the points outward) on the sides of a regular triangle, <br /> 
and form a closed curve of infinite length, called the Koch snowflake.
<a href="url"><img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Koch_curve_construction.svg/1200px-Koch_curve_construction.svg.png" align="right" width="250" height="230"></a>
The Koch curve is a typical geometric fractal. The process of its construction is as follows: we take a single segment, divide it into three equal parts and replace the middle interval with an equilateral triangle without this segment. As a result, a polyline is formed, consisting of four links of length 1/3. In the next step, we repeat the operation for each of the four resulting links, etc ... The limit curve is the Koch curve.

### Properties
- Paving with Koch snowflakes of two sizes
- The Koch curve is nowhere differentiable or straightenable.
- The Koch curve has infinite length.
- The Koch curve has no self-intersections.
- The Koch curve has an intermediate (that is, not an integer) Hausdorff dimension, which is equal to 4 l.\ lane 3, since it consists of four equal parts, each of which is similar to the entire curve with a similarity coefficient of 1/3.

Solving the problem using matlab. The number of iterations can be changed with the slider
```matlab
clc

x=[-1,0,1];             % X coordinates of the vertices of the original triangle
y=[0,sqrt(3),0];        % Y coordinates of the vertices of the original triangle
c=complex(x,y);         % transformation of each point into a complex number (so it is more convenient to calculate coordinates)
c(4)=c(1)
pause(1);
graphics(c)

function graphics(c)
  f = figure;
  plot (real(c), imaginary(c));         %building the initial triangle
  axis([-1.5 1.5 -1 2]);                % grid sizes
  axis square;
  bgcolor = f.Colour;

  % numbers for slider
  t1 = uicontrol('parent',f, 'style', 'text',...
  'position',[145 395 15 15],...
  ' String', '0',...
  'Background color', bgcolor);
  t2 = uicontrol('parent',f, 'style', 'text',...
  'position',[400 395 15 15],...
  ' String', '10',...
  'Background color', bgcolor);

  % the slider itself
  sld = uicontrol ('Parent', f, 'Style', slider,...
  "Min",0, "max", 10, "Value",0,...
  'String', 'X: ',...
  "Units", "Normalized"...
  "Position", [0.3 0.94 0.4 0.04],...
  "Callback", @print_val,...
  "Slide step" [1/1 1]);
end

  % state update function (takes values from slider)
function print_val(hObject,callbackdata)
  newval = hObject.value;                                     % take values from slider
  newval = round(newval);                                     %rounded to integers
  t.Int = newval;
  set(hObject, 'value', newval);                              % move slider to rounded position
  disp(['The number of iterations is ' num2str(newval)]);     % displays the number of iterations in the console (new value)
  draw_snowflake(newval);                                     % calling the end rendering function
                                                              


% drawing
function draw_snowflake(k)
  % we will set the initial triangle again
  x=[-1,0,1];
  y=[0,sqrt(3),0];
  c=complex(x,y);
  c(4)= c(1);

  if (k>0)
    for i=1:k
      n=size(c);                            % ≈ 1 4, 1 13, 1 49...
      n=n(2);                               % we take only the second number
      n=n-1;
      c1=complex (zeros(1,4*n),zeros(1,4*n));                             % we increase the array of points by 4 times, since each line is divided into 4 lines
      for j=1:n
        c1(4*j-3)=c(j);                                                     % the first point of the line corresponds to the first point of the previous line
        c1(4*j-2)=(c(j+1)-c(j))/3 + c(j);                                   % the second point on the line , but at a distance of 1/3 of the length of the line from 1 point
        c1(4*j)=c(j+1)-(c(j+1)-c(j))/3;                                     % the second point on a straight line , but at a distance of 1/3 of the length of the straight line from 2 points
        c1(4*j-1)=c1(4*j-2)+(c1(4*j)-c1(4*j-2))*complex(0.5,sqrt(3)/2);     % third vertex of an equilateral triangle with vertices c(4j-2) c(4j)
      end
      c=c1; % assign a new array instead of the old one
      c(4*n+1)=c(1); % last point - first point
    end
    plot(real(c), image(c)); %cyclic plotting
    axis([-1,5 1,5 -1 2]);
    axis square;
  end
end
```
<a href="url"><img src="https://github.com/goliksim/Matlab/blob/master/KochSnowflake/koch_img.png?raw=true"  text-align="middle" width="450" ></a>
<br />
And thanks again for your attention!
