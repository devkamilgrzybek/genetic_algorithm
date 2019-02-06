require_relative 'ga'
require_relative 'chromosome'

class KnapsackChromosome < Chromosome  
  WEIGHTS = [2.0, 3.0, 6.0, 7.0, 5.0, 9.0, 4.0, 7.0, 5.0, 9.0, 4.0, 16.0, 9.0, 15.0, 11.0, 4.0, 6.0]
  VALUES  = [6.0, 5.0, 8.0, 9.0, 6.0, 7.0, 3.0, 9.0, 6.0, 7.0, 3.0, 20.0, 8.0, 10.0, 11.0, 8.0, 13.0]
  CAPACITY = 30
  SIZE = WEIGHTS.length    
  
  def fitness
    w = count_weight
    v = count_value

    w > CAPACITY ? 0 : v
  end
  
  def show_bag
    weight = count_weight
    value = (weight > CAPACITY ? 0 : count_value)
    
    get_values.to_s+" #{weight} #{value}" 
  end
  
  def count_weight
    WEIGHTS
    .collect
    .with_index { |v, idx| value[idx].to_i * v }.inject(:+)
  end

  def count_value
    VALUES
    .collect
    .with_index { |v, idx| value[idx].to_i * v }.inject(:+)
  end

  def get_values
    VALUES
    .collect
    .with_index { |v, idx| value[idx].to_i * v }
  end

  def get_cap
    CAPACITY
  end
end

ga = GeneticAlgorithm.new

CROSSOVER = 0.4
MUTATION = 0.01
TRY = 100
POPULATION = 100
puts ga.run(KnapsackChromosome, CROSSOVER, MUTATION, TRY, POPULATION)
