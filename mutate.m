function mutated_generation = mutate(generation, mutation_rate, lower_bound, higher_bound, num_of_variables)
   total_genes = numel(generation);
   mutated_generation = generation;
   num_of_mutated_genes = round(mutation_rate * total_genes);

   mutated_genes_idx = randi([1 total_genes], 1, num_of_mutated_genes);

   for i=1:length(mutated_genes_idx)
       
       col = floor(mutated_genes_idx(i) / num_of_variables) +1;
       row = mod(mutated_genes_idx(i), num_of_variables);
       if col == 7
           col = col - 1;
       end
       if row == 0
           row = 4;
       end

       mutated_generation(row, col) = randi([lower_bound higher_bound]);
   end
end