function distance = Euclidean_distance(vector1, vector2)
    distance = sqrt(sum((vector1 - vector2).^2));
end