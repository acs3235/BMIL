function R = spatial_transform2(f, refl, distance)

for i = 1:length(f) 
    integral = cumtrapz(distance, distance .* besselj(0,2*pi*f(i)*distance) .* refl);
    R(i) = integral(end)
end