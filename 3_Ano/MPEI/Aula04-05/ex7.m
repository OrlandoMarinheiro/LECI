% 7 a) -----------------------
n = 15; % numero de mensagens por segundo
t = 4; % intervalo de tempo
lambda = n * t; % numero de eventos no intervalo de 4 segundos
k = 0; % numero de eventos que queremos observar
pk = (lambda^k * exp(-lambda)) / factorial(k);

fprintf("7 a) Probabilidade do servidor não receber nenhuma mensagem: %e\n", pk);

% 7 b) -----------------------

n = 15; % numero de mensagens por segundo
t = 4; % intervalo de tempo
lambda = n * t; % numero de eventos no intervalo de 4 segundos

% probabilidade de receber 40 mensagens
p40sms = 0;
for k = 0:40
    p40sms = p40sms + (lambda^k * exp(-lambda)) / factorial(k);
end

% probabilidade do servidor receber mais de 40 mensagens
pMais40sms = 1 - p40sms;
fprintf("7 b) Probabilidade do servidor receber mais de 40 mensagens: %e\n", pMais40sms);

