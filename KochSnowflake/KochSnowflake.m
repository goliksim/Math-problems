% Задание 5 - Голев А.С
% Снежинка Коха
clc

x=[-1,0,1];             % координаты Х вершин изначального треугольника
y=[0,sqrt(3),0];        % координаты Y вершин изначального треугольника
c=complex(x,y);         % преобразование каждой точки в комплексной число (так удобнее вычислять координаты)
c(4)=c(1)     
pause(1);
graphics(c) 

function graphics(c)
    f = figure;
    plot(real(c), imag(c));            %строим начальный треугольник
    axis([-1.5 1.5 -1 2]);             % размеры сетки
    axis square;
    bgcolor = f.Color;
    
    % циферки для слайдера
    t1 = uicontrol('Parent',f,'Style','text',... 
        'Position',[145 395 15 15],... 
        'String','0',... 
        'BackgroundColor',bgcolor);
    t2 = uicontrol('Parent',f,'Style','text',... 
        'Position',[400 395 15 15],... 
        'String','10',...
        'BackgroundColor',bgcolor);
    
    % сам слайдер 
    sld = uicontrol('Parent',f,'Style', 'slider',...
        'Min',0,'Max',10,'Value',0,...
        'String','X: ',...
        'Units', 'Normalized',...
        'Position', [0.3 0.94 0.4 0.04],...
        'Callback', @print_val,...
        'SliderStep', [1/1 1]); 
end
 
% функция обновления состояния (берет значения с слайдера)
function print_val(hObject,callbackdata)
    newval = hObject.Value;                         % берем значения с слайдера
    newval = round(newval);                         %округляем до целых
    t.Int = newval;
    set(hObject, 'Value', newval);                              % перемещаем слайдер до округленного положения
    disp(['Number of iteration is ' num2str(newval)]);          % отображаем число итераций в консоль
    draw_snowflake(newval)                                      % вызываем функцию отрисовки
end

% функция отрисовки
function draw_snowflake(k)
    % снова задем начальный треугольник
    x=[-1,0,1]; 
    y=[0,sqrt(3),0]; 
    c=complex(x,y);
    c(4)= c(1);
    
    if(k>0)  
        for i=1:k
            n=size(c);              % чтение размера массива с в виде 1 4, 1 13, 1 49...
            n=n(2);                 % берем только второе число
            n=n-1;  
            c1=complex(zeros(1,4*n),zeros(1,4*n));      % увеличиваем массив точек в 4 раза, так как каждая прямая делится на 4 прямых
            for j=1:n
                c1(4*j-3)=c(j);                                                     % первой точке прямой соответствует первая точка предыдущей прямой
                c1(4*j-2)=(c(j+1)-c(j))/3 + c(j);                                   % вторая точка на прямой , но расстоянии 1/3 длины прямой от 1 точки
                c1(4*j)=c(j+1)-(c(j+1)-c(j))/3;                                     % вторая точка на прямой , но расстоянии 1/3 длины прямой от 2 точки
                c1(4*j-1)=c1(4*j-2)+(c1(4*j)-c1(4*j-2))*complex(0.5,sqrt(3)/2);     % третья вершина равностороннего треугольника с вершинами c(4j-2) c(4j)
            end
            c=c1;                   % присваеваем новый массив вместо старого 
            c(4*n+1)=c(1);          % последняя точка - первая точка
        end
        plot(real(c), imag(c));     %цикличное построение графика
        axis([-1.5 1.5 -1 2]);
        axis square;
    end
end
