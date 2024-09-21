function probSimulacao = CalcProbSimul(N,p,k,n)
lancamentos = rand(n,N) > p;
sucessos= sum(lancamentos) ==k;
probSimulacao= sum(sucessos)/N;
end