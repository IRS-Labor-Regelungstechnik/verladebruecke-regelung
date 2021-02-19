c = param.k_AWG_K*param.eta_K;
ft = @(f) (0.5*c*dirac(f) - 1i*c/(2*pi*f))/(c-(2*pi*f)^2+ 1i*2*pi*f*(1/param.T_K));

f_steps = logspace(-3,3);

res = zeros(size(f_steps));
for i = length(f_steps)
    res(i) = ft(f_steps(i));
end

plot(f_steps, abs(res))