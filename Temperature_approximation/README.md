Задача аппроксимации показателей температуры 20 метеорологических станций.

Имеется 20 метеорологических станций, измеряющих температуру, необходимо
аппроксимировать результаты измерения на двумерную сетку региона. Использовать
следующую функцию.

<a href="url"><img src="https://github.com/goliksim/Matlab/blob/master/Temperature_approximation/apprx_img_3.png?raw=true"  text-align="middle" width="250" ></a>

где rL(x,y) – расстояние от точки (x,y) до L метеостанции, TL – значение температуры на L-
ой станции, C(x,y) – нормировочный множитель, чем ближе точка (x,y) к станции, тем с
большим весом берется соответствующее слагаемое TL

<img src="https://github.com/goliksim/Matlab/blob/master/Temperature_approximation/apprx_img_4.png?raw=true"  text-align="middle" width="200" >

Отобразить получившееся поле температур на графике. Значения температур и
координаты станций задать в текстовом файле.
Создать свою функцию, принимающую название файла, шаг сетки и возвращающую
сетку [X Y] и двумерный массив значений температуры в узлах этой сетки.

Для начала создадим .txt файл со значениями температуры кадой станции и ее координатами. 
```matlab
% Функция создает начальные данные для задачи со станциями

T= zeros(20,3);                         % задаем пустую матрицу 20 3
T(:,1)=(-30 + int8((70)*rand(20,1)));   % первый столб - значения температуры (-30:40) градусов
T(:,2)=(0 + int8((20)*rand(20,1)));     % второй и третий столбы - координаты х и у
T(:,3)=(0 + int8((20)*rand(20,1)))
formatSpec = '%d %d %d\n';
stations = fopen('stations.txt','w');   % открываем файл
fprintf(stations, formatSpec, T');      % записываем массив
fclose(stations);                       



% отобразим данные для понимания
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

Теперь напишем функцию аппроксимации, которая принимает параметры: имя файла, шаг сетки.

```matlab
% функция апроксимации данных на сетку
% выводит результат в виде графика, а также массив значений в консоль 

function Aproximate(name, step)
    A = load(name)                       % загрузка массива с исходными температурами
    Size = max(max(A(:,2)),max(A(:,3))); % вычисляем размер сетки (макс Х или У)
    ScaledSize = Size/step;              % из-за шага сетки массив будет больше
    T=zeros(ScaledSize,ScaledSize);      % массив для сетки
    onPick=0;                            % в точках станций С будет = inf, поэтому это нужно обрабатывать отдельно
    for x = 1:ScaledSize
        for y = 1:ScaledSize
            C=0;
            Tl=0;
            for i = 1:20
                C=(1./((x-A(i,2)./step).^2+(y-A(i,3)./step).^2))+C;                 % считаем сумму С для точки х у
                if isinf(C)                 % если = inf , то присваеваем точке значение температуры станции
                    i
                    T(x,y)=A(i,1);
                    onPick=1;
                    break
                end
                Tl=Tl+(A(i,1)/((x-A(i,2)./step).^2+(y-A(i,3)./step).^2));           % считаем сумму Tl для точки х у
            end
            
            if (onPick == 0)                % если не на пике, то вычисляем итоговое значение температуры в х у
                T(x,y)=Tl/C;
            end
            onPick=0;
        end
    end
    
    [X,Y] = meshgrid(1:ScaledSize); % задаем размеры сетки
    b = surf(X*step,Y*step,T);      % строим сетку и масштабируем обратно подписи координат
    b.EdgeColor = 'none';           % убираем грани сетки
    xlabel('x')                     % подписи осей
    ylabel('y')
    
    % есть возможность также отобразить данные в виде диаграммы 
    %b = bar3(T);
    %for k = 1:length(b)
    %    zdata = b(k).ZData;
    %    b(k).CData = zdata;
    %    b(k).FaceColor = 'interp';
    %end
    T
end
```
И наконец файл запуска.

```matlab
% вызываем функцию апроксимации и передаем ей имя файла с данными и шаг сетки 
Aproximate("stations.txt",0.125)
% здесь "stations.txt" - название файла с исходными данные, которые были созданы функцией Stations_create
% 0.25 - шаг сетки 
% исходные данные созданы с шагом в 1 в пределах 20 по х и у
% шаг в 0.25 увеличит итоговый массив в 4 раза (график будет плавнее)
```
<img src="https://github.com/goliksim/Matlab/blob/master/Temperature_approximation/apprx_img_2.png?raw=true"  text-align="middle" width="300" >
На этом все.
