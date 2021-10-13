% ������� 5 - ����� �.�
% �������� ����
clc

x=[-1,0,1];             % ���������� � ������ ������������ ������������
y=[0,sqrt(3),0];        % ���������� Y ������ ������������ ������������
c=complex(x,y);         % �������������� ������ ����� � ����������� ����� (��� ������� ��������� ����������)
c(4)=c(1)     
pause(1);
graphics(c) 

function graphics(c)
    f = figure;
    plot(real(c), imag(c));            %������ ��������� �����������
    axis([-1.5 1.5 -1 2]);             % ������� �����
    axis square;
    bgcolor = f.Color;
    
    % ������� ��� ��������
    t1 = uicontrol('Parent',f,'Style','text',...
        'Position',[145 395 15 15],...
        'String','0',...
        'BackgroundColor',bgcolor);
    t2 = uicontrol('Parent',f,'Style','text',...
        'Position',[400 395 15 15],...
        'String','10',...
        'BackgroundColor',bgcolor);
    
    % ��� ������� 
    sld = uicontrol('Parent',f,'Style', 'slider',...
        'Min',0,'Max',10,'Value',0,...
        'String','X: ',...
        'Units', 'Normalized',...
        'Position', [0.3 0.94 0.4 0.04],...
        'Callback', @print_val,...
        'SliderStep', [1/1 1]); 
end
 
% ������� ���������� ��������� (����� �������� � ��������)
function print_val(hObject,callbackdata)
    newval = hObject.Value;                         % ����� �������� � ��������
    newval = round(newval);                         %��������� �� �����
    t.Int = newval;
    set(hObject, 'Value', newval);                              % ���������� ������� �� ������������ ���������
    disp(['Number of iteration is ' num2str(newval)]);          % ���������� ����� �������� � �������
    draw_snowflake(newval)                                      % �������� ������� ���������
end

% ������� ���������
function draw_snowflake(k)
    % ����� ����� ��������� �����������
    x=[-1,0,1]; 
    y=[0,sqrt(3),0]; 
    c=complex(x,y);
    c(4)= c(1);
    
    if(k>0)  
        for i=1:k
            n=size(c);              % ������ ������� ������� � � ���� 1 4, 1 13, 1 49...
            n=n(2);                 % ����� ������ ������ �����
            n=n-1;  
            c1=complex(zeros(1,4*n),zeros(1,4*n));      % ����������� ������ ����� � 4 ����, ��� ��� ������ ������ ������� �� 4 ������
            for j=1:n
                c1(4*j-3)=c(j);                                                     % ������ ����� ������ ������������� ������ ����� ���������� ������
                c1(4*j-2)=(c(j+1)-c(j))/3 + c(j);                                   % ������ ����� �� ������ , �� ���������� 1/3 ����� ������ �� 1 �����
                c1(4*j)=c(j+1)-(c(j+1)-c(j))/3;                                     % ������ ����� �� ������ , �� ���������� 1/3 ����� ������ �� 2 �����
                c1(4*j-1)=c1(4*j-2)+(c1(4*j)-c1(4*j-2))*complex(0.5,sqrt(3)/2);     % ������ ������� ��������������� ������������ � ��������� c(4j-2) c(4j)
            end
            c=c1;                   % ����������� ����� ������ ������ ������� 
            c(4*n+1)=c(1);          % ��������� ����� - ������ �����
        end
        plot(real(c), imag(c));     %��������� ���������� �������
        axis([-1.5 1.5 -1 2]);
        axis square;
    end
end
 