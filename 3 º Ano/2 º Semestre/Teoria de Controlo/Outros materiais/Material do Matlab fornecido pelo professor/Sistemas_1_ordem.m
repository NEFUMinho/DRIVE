clc;clear
%% Sistemas de 1ª ordem
num = [0 1];
dem = [1 1];

figure(1);
step(num,dem);
title('Resposta ao degrau unitário de G(s)=1/s+1')

%% Resposta consoante a constante de tempo
numA = [0 1];
demA = [0.5 1]; % para T=0.5

numB = [0 1];
demB = [1 1]; % para T=1 

numC = [0 1];
demC = [2 1]; % para T=2

G1= tf(numA,demA);
G2= tf(numB,demB);
G3= tf(numC,demC);

figure(2);
h = stepplot(G1,G2,G3);
legend('G1=1/0.5s+1','G2=1/s+1','G3=1/2s+1');

%% Resposta  a rampa unitária 
t=0:0.1:10;
alpha=1;
ramp=alpha*t;         % Your input signal
model=tf(1,[1 1]);    % Your transfer function
[y,t]=lsim(model,ramp,t);
figure(3);
plot(t,y,'o',t,t,'-');
title('Resposta a rampa unitária de G(s)=1/s+1')
legend('g(t)','r(t)');

%% Resposta ao impulso unitário
num = [0 1];
dem = [10 1];

figure(4);
impulse(num,dem);
title('Resposta ao impulso unitário de G(s)=1/10s+1');

%% Exemplo carro
m=1000;
F=250;
B=50;
v_cruzeiro=10;

t_r=0:0.1:180;
num_c=[0 F/m];
dem_c=[1 B/m];
G_c= tf(num_c,dem_c);
S=stepinfo(G_c)

figure(5);
Y=step(G_c,t_r);
plot(t_r, Y,'c');
hline1=refline([0 v_cruzeiro]);
hline1.Color = 'g';
hline2=refline([0 5]);
hline2.Color = 'r';
axis([0 inf 0 12]);
title('Resposta ao degrau unitário da velocidade do carro');
legend('System Step Response','Desired cruise velocity','steady-state value');

% Find the value for t=T(tau) where 1T = 0.6321205588
yi=Y(end)
idx=max(find(abs(Y-yi)>=(1-0.6321205588)*yi))
Y(idx)
t_r(idx)
