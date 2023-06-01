function New_Generation = mating(Old_generation, parents_idx, num_of_variables)
    New_Generation = Old_generation;
    C = randi([1 num_of_variables-1], 1, length(parents_idx)-1);
    
    for i= 1:length(parents_idx)-1
        offspring_chromosome = Old_generation(:,parents_idx(i));
        offspring_chromosome(C(i)+1 : end) = Old_generation(C(i)+1:end , parents_idx(i+1));
        
        New_Generation(:,parents_idx(i)) = offspring_chromosome;
    end
end