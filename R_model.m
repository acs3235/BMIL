function R = R_model(gamma, mu, f)
%f can be a vector, gamma and mu must be scalars

eta = 0.003;
leci = [68.6, 0.98, 0.61, 16.6];

R = eta*(1 + (leci(4)*gamma^(-2))*(mu * f.^(-1)).^(-leci(3)*gamma)) .* (mu * f.^(-1)).^(-leci(2)*gamma)./(leci(1)*gamma^2 + (mu*f.^(-1)).^(-leci(2)*gamma));

end