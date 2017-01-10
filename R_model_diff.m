function R = R_model_diff(mu_a, mu_s, f)
%f can be a vector, gamma and mu must be scalars

utr = mu_a + mu_s;

ap = mu_s/utr;

R = (3*ap*mu_s/utr)./((sqrt(3*mu_a*utr + (2*pi*f).^2)/utr + 1).*(sqrt(3 * mu_a * utr + (2 * pi * f).^2)/utr + 3*ap));

end