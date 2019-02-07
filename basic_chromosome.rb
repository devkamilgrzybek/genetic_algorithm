require_relative 'ga'
require_relative 'chromosome'

class BinaryChromosome < Chromosome
  def fitness
    c1 = value.count("0") * 0
    c2 = value.count("1") * 10

    c1 + c2
  end
end