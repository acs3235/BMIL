%Andrew Stier
%Based off of equation from (cite paper)

function Rf = spatial_transform(f,Rp,d,dr)

for i = 1:length(f)
    Rf(i) = 2*pi*sum(d .* besselj(0,2*pi*f(i)*d) .* Rp * dr);
end
