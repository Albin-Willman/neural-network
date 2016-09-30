class Breeder
  attr_accessor :random

  def initialize(seed = nil)
    @random = seed ? Random.new(seed) : Random.new
  end

  def mate(mom, dad)
    raise LengthMissmatchError unless mom.length == dad.length
    mutate(mix_parents(mom, dad))
  end

  private

  def mutate(offspring)
    offspring.map do |e|
      p = random.rand
      if p < 0.2
        100 * (random.rand - 0.5)
      elsif p < 0.4
        e + (random.rand - 0.5)
      else
        e
      end
    end
  end

  def mix_parents(mom, dad)
    offspring = []
    mom.length.times do |i|
      offspring[i] = random.rand > 0.5 ? mom[i] : dad[i]
    end
    offspring
  end

end

class LengthMissmatchError < StandardError
end
