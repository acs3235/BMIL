function R = spatial_transform(f, refl, distance, dr)

for i = 1:length(f) 
    R(i) = 2*pi*sum(distance .* besselj(0,2*pi*f(i)*distance) .* refl * dr);
end