function [ call_price ] = price_call_mc( s0,K,r,sigma,T,n )
    rands = normrnd(0,1,n,1);
    sT = s0.*exp((r-sigma.^2/2).*T+rands.*sigma.*sqrt(T));
    call_values = max(0,sT-K);
    call_price = mean(call_values).*exp(-r.*T);
end

