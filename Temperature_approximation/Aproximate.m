% ������� ������������ ������ �� �����
% ������� ��������� � ���� �������, � ����� ������ �������� � ������� 
% ����� �.�.

function Aproximate(name, step)
    A = load(name)                       % �������� ������� � ��������� �������������
    Size = max(max(A(:,2)),max(A(:,3))); % ��������� ������ ����� (���� � ��� �)
    ScaledSize = Size/step;              % ��-�� ���� ����� ������ ����� ������
    T=zeros(ScaledSize,ScaledSize);      % ������ ��� �����
    onPick=0;                            % � ������ ������� � ����� = inf, ������� ��� ����� ������������ ��������
    for x = 1:ScaledSize
        for y = 1:ScaledSize
            C=0;
            Tl=0;
            for i = 1:20
                C=(1./((x-A(i,2)./step).^2+(y-A(i,3)./step).^2))+C;                 % ������� ����� � ��� ����� � �
                if isinf(C)                 % ���� = inf , �� ����������� ����� �������� ����������� �������
                    i
                    T(x,y)=A(i,1);
                    onPick=1;
                    break
                end
                Tl=Tl+(A(i,1)/((x-A(i,2)./step).^2+(y-A(i,3)./step).^2));           % ������� ����� Tl ��� ����� � �
            end
            
            if (onPick == 0)                % ���� �� �� ����, �� ��������� �������� �������� ����������� � � �
                T(x,y)=Tl/C;
            end
            onPick=0;
        end
    end
    
    [X,Y] = meshgrid(1:ScaledSize); % ������ ������� �����
    b = surf(X*step,Y*step,T);      % ������ ����� � ������������ ������� ������� ���������
    b.EdgeColor = 'none';           % ������� ����� �����
    xlabel('x')                     % ������� ����
    ylabel('y')
    
    % ���� ����������� ����� ���������� ������ � ���� ��������� 
    %b = bar3(T);
    %for k = 1:length(b)
    %    zdata = b(k).ZData;
    %    b(k).CData = zdata;
    %    b(k).FaceColor = 'interp';
    %end
    T
end