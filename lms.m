%Experimento 2
%Exercicio 3

%ANALISE DE CONVERGENCIA DO ALGORITMO LMS

%Delimita a ordem do sistema
sysorder = 8 ;
% Number of system points
N=2000;
inp = randn(N,1);
n = randn(N,1);
[b,a] = butter(2,0.25);
Gz = tf(b,a,-1);
%This function is submitted to make inverse Z-transform (Matlab central file exchange)
%The first sysorder weight value
%h=ldiv(b,a,sysorder)';
% if you use ldiv this will give h :filter weights to be
h=  [0.0976;
    0.2873;
    0.3360;
    0.2210;
    0.0964;];
y = lsim(Gz,inp);
%Adiciona ruido
n = n * std(y)/(10*std(n));
d = y + n;
totallength=size(d,1);
%Utiliza 60 pontos para a convergencia
N=60 ;	
%Inicio do algoritmo LMS
w = zeros ( sysorder  , 1 ) ;
for n = sysorder : N 
	u = inp(n:-1:n-sysorder+1) ;
    y(n)= w' * u;
    e(n) = d(n) - y(n) ;

% Inicia com um mu grande para convergencia rapida, entao diminui para se aproximar dos pesos corretos  
    if n < 20
        mu=0.32; %original 0.32
    else
        mu=0.15;  %original 0.15
    end
	w = w + mu * u * e(n) ;
end 
%Verifica os resultados
for n =  N+1 : totallength
	u = inp(n:-1:n-sysorder+1) ;
    y(n) = w' * u ;
    e(n) = d(n) - y(n) ;
end 
hold on
plot(d)
plot(y,'r');
title('Saida do Sistema') ;
xlabel('Amostras');
ylabel('Saidas real e estimada');
figure;
semilogy((abs(e))) ;
title('Curva de erro') ;
xlabel('Amostras');
ylabel('Erro');
figure;
plot(h, 'k+');
hold on;
plot(w, 'r*');
legend('Pesos atuais','Pesos estimados');
title('Comparacao entre os pesos atuais e estimados') ;
axis([0 6 0.05 0.35]);

%Baseado no algoritmo de Tamer abdelazim Mellik, Department of Electrical & Computer Engineering,
% University of Calgary. 
% Referencia : S. Haykin, Adaptive Filter Theory. 3rd edition, Upper Saddle River, NJ: Prentice-Hall, 1996. 

