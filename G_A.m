clear;
clc;

lower_bound = 0;
higher_bound = 30;

num_of_variables = 4;
num_of_chromosomes = 6;
num_of_generations = 100;
mutation_rate = 0.1;

crossover_rate = 0.25;

F_obj = zeros(1,num_of_chromosomes);
Fitness = zeros(1,num_of_chromosomes);

best_objFunc = zeros(1, num_of_generations);
generations = zeros(1, num_of_generations);

generation = randi([lower_bound higher_bound], num_of_variables, num_of_chromosomes);

for gen = 1:num_of_generations
    for i = 1:num_of_chromosomes
        F_obj(i) = abs(objFunc(generation(:,i)));
        Fitness(i) = 1 / (1 + F_obj(i));
    end
    
    Total_fitness = sum(Fitness);
    Probability_of_staying = Fitness / Total_fitness;
    
    C = cumsum(Probability_of_staying);
    R = rand(1,num_of_chromosomes);
    
    NewChromosomes = zeros(num_of_variables, num_of_chromosomes);
    
    for i = 1:num_of_chromosomes
        chromosome_idx = find(C <= R(i), 1, 'last');
        if isempty(chromosome_idx)
            chromosome_idx = 0;
        end
        chromosome_idx = chromosome_idx + 1;
    
        NewChromosomes(:,i) = generation(:,chromosome_idx);
    end
    
    R = rand(1,num_of_chromosomes);
    parents_idx = find(R < crossover_rate);
    
    if ~isempty(parents_idx) 
        parents_idx(length(parents_idx) + 1) = parents_idx(1);
    end
    
    if length(parents_idx) > 2
        new_generation = mating(NewChromosomes, parents_idx, num_of_variables);
    else
        new_generation = NewChromosomes;
    end
    
    mutated_generation = mutate(new_generation, mutation_rate, lower_bound, higher_bound, num_of_variables);
    generation = mutated_generation;

    best_objFunc(gen) = min(F_obj);
    generations(gen) = gen;
end

final_objFunc = zeros(1, num_of_chromosomes);
for i = 1:num_of_chromosomes
        final_objFunc(i) = abs(objFunc(generation(:,i)));
end

[minimum_objFunc, best_chromosome] = min(final_objFunc);

disp("Best chromosome = ")
disp(generation(:,best_chromosome)')
disp("Objective function of best chromosome = ")
disp(final_objFunc(best_chromosome))

figure;
plot(generations, best_objFunc)
title("Minimum value for objective function in each generation")
xlabel("Number of generation")
ylabel("Minimum value for objective function")