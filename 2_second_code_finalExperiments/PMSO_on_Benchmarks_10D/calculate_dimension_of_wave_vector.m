function WaveDisplacement_in_dimension = calculate_dimension_of_wave_vector(WaveDisplacement_magnitude, WaveDisplacement_angle, dimension)

global Number_of_dimensions_of_landscape;
multiplication_of_cosines_and_sines_of_angles = 1;

if dimension == 1
    multiplication_of_cosines_and_sines_of_angles = cos(WaveDisplacement_angle(dimension));
elseif dimension == Number_of_dimensions_of_landscape
    for previous_dimension = 1:dimension-2
        multiplication_of_cosines_and_sines_of_angles = multiplication_of_cosines_and_sines_of_angles * sin(WaveDisplacement_angle(previous_dimension));
    end
    multiplication_of_cosines_and_sines_of_angles = multiplication_of_cosines_and_sines_of_angles * sin(WaveDisplacement_angle(dimension-1));
else
    for previous_dimension = 1:dimension-1
        multiplication_of_cosines_and_sines_of_angles = multiplication_of_cosines_and_sines_of_angles * sin(WaveDisplacement_angle(previous_dimension));
    end
    multiplication_of_cosines_and_sines_of_angles = multiplication_of_cosines_and_sines_of_angles * cos(WaveDisplacement_angle(dimension));
end

WaveDisplacement_in_dimension = WaveDisplacement_magnitude * multiplication_of_cosines_and_sines_of_angles;

end