% функция апроксимации данных на сетку
% выводит результат в виде графика, а также массив значений в консоль 
% Голев А.С.

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