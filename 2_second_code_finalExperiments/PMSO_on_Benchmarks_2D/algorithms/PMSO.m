%% Pontogammarus Maeoticus Swarm Optimization (PMSO) Algorithm
function [bestFitnessLocation, bestFitness] = PMSO(function_landscape, Number_of_particles)

%%%%%%% Global variables:
global initial_flag
initial_flag=0;  %--> We have to do this in the first of code! (according to code and instruction of benchmark dataset)
global Number_of_dimensions_of_landscape;
global Maximum_number_of_function_evaluations;

%%% Parameters of Algorithm:
%%%%%% parameters of local search iterations:
global Number_of_iterations_in_LocalSearch;
global lowerBound_of_iterationLocalSearch;
%%%%%% parameters of wave determination:
global fraction_of_particles_close_to_sea_edge;
%%%%%% parameters of local search neighborhood:
global fraction_of_distance_from_globalBest_for_neighborhood;
global neighborhood_of_globalBest_particle;
global initial_neighborhood;
global rate_change_neighborhood;
global lowerBound_of_neighborhood;
global upperBound_of_neighborhood;
global FitnessHistory_window_ChangeNeighbourhood;

%%%%%%% initializations:
[bounds_of_search, initialization_range] = get_bounds_of_benchmark(function_landscape);
x_min_landscape = bounds_of_search(1);
x_max_landscape = bounds_of_search(2);
x_min_initialization = initialization_range(1);
x_max_initialization = initialization_range(2);
bestFitnessLocation = zeros(1,Number_of_dimensions_of_landscape);
bestFitness = 0;
GammarusLoc = zeros(Number_of_particles,Number_of_dimensions_of_landscape);  %--> row: Gammarus individual, column: dimension of location
WaveDisplacement = zeros(1,Number_of_dimensions_of_landscape);
WaveDisplacement_angle = zeros(1,Number_of_dimensions_of_landscape-1);
local_search_location = zeros(1,Number_of_dimensions_of_landscape);
history_of_fitness_of_particles = cell(Number_of_particles,1);
status_neighborhood = cell(Number_of_particles,1);

%%%%%%% Algorithm:
globalIteration = 0;
number_of_function_evaluations = 0;
while number_of_function_evaluations <= Maximum_number_of_function_evaluations
    %%%%%%% global iterations:
    %disp(number_of_function_evaluations)
    globalIteration = globalIteration + 1;
    %%%%%%% find distance_of_particles_from_global_best:
    if globalIteration ~= 1 
        for particle = 1:Number_of_particles
            distance_of_particles_from_global_best(particle) = Euclidean_distance(bestFitnessLocation, GammarusLoc(particle,:));
        end
        [~,indices_of_sorted_distances] = sort(distance_of_particles_from_global_best);
        particles_close_to_sea_edge = indices_of_sorted_distances(1:round(fraction_of_particles_close_to_sea_edge*Number_of_particles));
    end
    %%%%%%% interation on particles:
    for particle = 1:Number_of_particles
        %%%%%%% updating locations of Gammarus individuals:
        collision_occured = true;
        while collision_occured == true
            if globalIteration ~= 1  
                GammarusDistanceToSeaEdge = distance_of_particles_from_global_best(particle);
                %%%%%%% finding angle of wave:
                if isempty(particles_close_to_sea_edge(particles_close_to_sea_edge == particle))   % if the particle is far from sea edge ===> wave should be random in direction
                    %%%%%%% finding strength (magnitude) of wave:
                    WaveDisplacement_magnitude = rand * GammarusDistanceToSeaEdge;
                    for dimension = 1:Number_of_dimensions_of_landscape
                        while 1
                            if dimension <= Number_of_dimensions_of_landscape-1
                                WaveDisplacement_angle(dimension) = 2*pi*rand;
                            end
                            WaveDisplacement(dimension) = calculate_dimension_of_wave_vector(WaveDisplacement_magnitude, WaveDisplacement_angle, dimension);
                            new_candidate_location_of_Gammarus(dimension) = GammarusLoc(particle,dimension) + WaveDisplacement(dimension);
                            %%%%%%% check whether is in landscape limit:
                            if new_candidate_location_of_Gammarus(dimension) >= x_min_landscape && new_candidate_location_of_Gammarus(dimension) <= x_max_landscape
                                break;
                            elseif dimension == Number_of_dimensions_of_landscape
                                dimension = dimension - 1;
                            end
                        end
                    end
                else    % if the particle is close to sea edge ===> wave should be toward the global best
                    vector_from_particle_to_global_best = bestFitnessLocation - GammarusLoc(particle,:);
                    for dimension = 1:Number_of_dimensions_of_landscape
                        if dimension <= Number_of_dimensions_of_landscape-2
                            nominator = sqrt(sum(vector_from_particle_to_global_best(dimension+1:Number_of_dimensions_of_landscape).^2));
                            dinominator = vector_from_particle_to_global_best(dimension);
                            WaveDisplacement_angle(dimension) = atan2(nominator, dinominator);
                        elseif dimension == Number_of_dimensions_of_landscape - 1
                            nominator = vector_from_particle_to_global_best(Number_of_dimensions_of_landscape);
                            dinominator = vector_from_particle_to_global_best(Number_of_dimensions_of_landscape-1) + sqrt(vector_from_particle_to_global_best(Number_of_dimensions_of_landscape)^2 + vector_from_particle_to_global_best(Number_of_dimensions_of_landscape-1)^2);
                            WaveDisplacement_angle(dimension) = 2 * atan2(nominator, dinominator);
                        end
                    end
                    tic
                    time_ = 0;
                    while 1
                        %%%%%%% finding strength (magnitude) of wave:
                        WaveDisplacement_magnitude = rand * GammarusDistanceToSeaEdge;
                        for dimension = 1:Number_of_dimensions_of_landscape
                            WaveDisplacement(dimension) = calculate_dimension_of_wave_vector(WaveDisplacement_magnitude, WaveDisplacement_angle, dimension);
                            new_candidate_location_of_Gammarus(dimension) = GammarusLoc(particle,dimension) + WaveDisplacement(dimension);
                        end
                        %%%%%%% check whether is in landscape limit:
                        can_break_loop = 1;
                        for dimension = 1:Number_of_dimensions_of_landscape
                            if ~(new_candidate_location_of_Gammarus(dimension) >= x_min_landscape && new_candidate_location_of_Gammarus(dimension) <= x_max_landscape)
                                can_break_loop = 0;
                            end
                        end
                        if can_break_loop == 1
                            break;
                        end
                        if time_ >= 90   % if is stuck (for 90 seconds or more) (perhaps because global best is near landscape bounds and founder of global best gets stuck in loop)
%                             for dimension = 1:Number_of_dimensions_of_landscape
%                                 WaveDisplacement(dimension) = 0;
%                             end
%                             break;
                            bestFitnessLocation = [];
                            bestFitness = [];
                            return
                        end
                        time_ = toc;
                    end
                end
                %%%%%%% collision check:
                collision_occured = false;
            else
                %%%%%%% Random initialization of location particles in landscape:
                new_candidate_location_of_Gammarus = x_min_initialization + (x_max_initialization - x_min_initialization)*rand(1,Number_of_dimensions_of_landscape);
                %%%%%%% collision check:
                collision_occured = false;
                for previous_particle = 1:(particle-1)
                    if Euclidean_distance(new_candidate_location_of_Gammarus, GammarusLoc(previous_particle,:)) <= initial_neighborhood
                        collision_occured = true;
                        break;
                    end
                end
            end
        end
        if globalIteration ~= 1 
            if particle ~= founder_of_global_best
                GammarusLoc(particle,:) = GammarusLoc(particle,:) + WaveDisplacement;
            else
                GammarusLoc(particle,:) = bestFitnessLocation;
            end
        else
            GammarusLoc(particle,:) = new_candidate_location_of_Gammarus;
        end
        %%%%%%% Determining the neighborhood according to distance from the global best found so far:
        if globalIteration ~= 1 
            if particle ~= founder_of_global_best
                new_distance_from_global_best_found_so_far = Euclidean_distance(GammarusLoc(particle,:), bestFitnessLocation);
                neighborhood = fraction_of_distance_from_globalBest_for_neighborhood * new_distance_from_global_best_found_so_far;
            else
                neighborhood = neighborhood_of_globalBest_particle;
            end
        else
            neighborhood = initial_neighborhood;
        end
        %%%%%%% Local Search:
        status_neighborhood{particle} = 'no_change';
        for local_search_index = 1:Number_of_iterations_in_LocalSearch
            %%%% updating neighborhood in local search:
            if local_search_index == 1
                history_of_fitness_of_particles{particle} = [];
            elseif local_search_index >= FitnessHistory_window_ChangeNeighbourhood+1
                if min(history_of_fitness_of_particles{particle}(end-FitnessHistory_window_ChangeNeighbourhood+1:end)) >= min(history_of_fitness_of_particles{particle})
                    if strcmp(status_neighborhood{particle}, 'no_change')
                        neighborhood = min(neighborhood * (1 + rate_change_neighborhood), upperBound_of_neighborhood);
                        status_neighborhood{particle} = 'increase';
                    elseif strcmp(status_neighborhood{particle}, 'increase')
                        neighborhood = max(neighborhood * (1 - rate_change_neighborhood), lowerBound_of_neighborhood);
                        status_neighborhood{particle} = 'decrease';
                    elseif strcmp(status_neighborhood{particle}, 'decrease')
                        neighborhood = min(neighborhood * (1 + rate_change_neighborhood), upperBound_of_neighborhood);
                        status_neighborhood{particle} = 'increase';
                    end
                end
            end
            %%%% local search:
            for dimension = 1:Number_of_dimensions_of_landscape
                min_neighborhood = max(x_min_landscape, GammarusLoc(particle,dimension)-neighborhood);
                max_neighborhood = min(x_max_landscape, GammarusLoc(particle,dimension)+neighborhood);
                local_search_location(dimension) = min_neighborhood + (max_neighborhood - min_neighborhood)*rand;
            end
            fitness = benchmark_func(local_search_location, function_landscape);
            number_of_function_evaluations = number_of_function_evaluations + 1;
            %%%% updating history of fitness of particles:
            history_of_fitness_of_particles{particle} = [history_of_fitness_of_particles{particle}, fitness];
            %%%% updating global best if necessary:
            if (globalIteration == 1 && particle == 1 && local_search_index == 1) %% if first gammarus in first iteration of all
                bestFitness = fitness;
                bestFitnessLocation = local_search_location;
                founder_of_global_best = particle;
            elseif fitness < bestFitness
                bestFitness = fitness;
                bestFitnessLocation = local_search_location;
                founder_of_global_best = particle;
                GammarusLoc(particle,:) = bestFitnessLocation;
            end
            %%%% translating particle to its new best found during its local search:
            if fitness < min(history_of_fitness_of_particles{particle})
                GammarusLoc(particle,:) = local_search_location;
            end 
        end
    end
    %%%%%%% Decreasing Number_of_iterations_in_LocalSearch and neighborhood (decreasing SoftnessOfSand):
    Number_of_iterations_in_LocalSearch = max(Number_of_iterations_in_LocalSearch-1, lowerBound_of_iterationLocalSearch);
end

end