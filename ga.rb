
class GeneticAlgorithm
  def generate(chromosome)
    value = Array.new(chromosome::SIZE) { ["0", "1"].sample }

    chromosome.new(value)
  end

  def select(population)
    population.sample(2)
  end

  def crossover(selection, index, chromosome)
    cr1 = selection[0][0...index] + selection[1][index..-1]
    cr2 = selection[1][0...index] + selection[0][index..-1]

    [chromosome.new(cr1), chromosome.new(cr2)]
  end

  def run(chromosome, p_cross, p_mutation, iterations = 100, p_population) 
    # initial population
    population = p_population.times.map { generate(chromosome) }
    visualize = true
    current_generation = population
    next_generation    = []

    iterations.times do |i|
      if visualize  
        puts ""
        puts '--------------------------------------------'
        puts "TRY "+(i+1).to_s
        puts '--------------------------------------------'
          
        puts "\tCURRENT GENERATION"
        current_generation.each do |f|
          #if f.count_weight < f.get_cap
            puts "\t\t #{f.show_bag}"
          #end
        end

      end
      # save best fit
      best_fit = current_generation.max_by { |ch| ch.fitness }.dup
      
      (population.size).times do |i|        
        selection = select(current_generation)

        if visualize
          puts "-------------------------"
          puts "\GENERATION "+(i+1).to_s
          puts "-------------------------"

          puts "\tSELECTION"
          selection.each{ |f| puts "\t\t"+f.value.join }
        end
        
        # crossover
        if rand < p_cross
          selection = crossover(selection, rand(0..chromosome::SIZE), chromosome)
          if visualize
            puts "\tCROSSOVER"
            selection.each{|f| puts "\t\t"+f.value.join}
          end
        end
        
        # mutation
        selection[0].mutate(p_mutation)
        selection[1].mutate(p_mutation)
        if visualize
          puts "\tMUTATION"
          puts "\t\t"+selection[0].value.join
          puts "\t\t"+selection[1].value.join
        end

        # przesuniecie bitowe?
        next_generation << selection[0] << selection[1]        
        if visualize
          puts "\tNEXT GENERATION"
          next_generation.each do |f|
            if f.count_weight < f.get_cap
              puts "\t\t #{f.show_bag}"
            end
          end
        end
        next_generation
      end
      
      current_generation = next_generation
      next_generation = []
      
      # Make sure best fit chromosome carries over
      current_generation << best_fit
      current_generation
    end

    # return best solution
    best_fit = current_generation.max_by { |ch| ch.fitness }
    
    puts ""
    puts "\tFINAL RESULT"
    best_fit.fitness > 0 ? "\t"+best_fit.show_bag : "\tSorry tune up params, probably to low population to mutate solution" 
  end
end
