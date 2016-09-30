require_relative './Spawner'
require_relative './NeuralNet'
require_relative './Breeder'
require_relative './TrainingUtilities'
Struct.new('Candidate', :error, :weights)
Struct.new('Example', :expected, :inputs)

class Trainer
  attr_accessor :inputs, :cattle, :shape, :training_data

  NUMBER_IN_HERD = 30
  def initialize(inputs, shape)
    @inputs = inputs
    @shape = shape
  end

  def exercise(training_data, max_iterations, error_threshold)
    puts "Starting"
    @training_data = training_data
    build_intial_lifestock unless cattle
    max_iterations.times do |i|
      print_status(i)
      next_generation
      return build_net(cattle.first.weights) if cattle.first.error < error_threshold
    end
    build_net(cattle.first.weights)
  end

  private

  def print_status(i)
    puts "Iteration #{i}"
    puts "Min error: #{cattle.first.error}"
  end

  def next_generation
    2.times do
      @cattle << evaluate_candidate(spawner.spawn)
    end
    parent_pairs = make_matches
    breeder = Breeder.new
    parent_pairs.each do |pair|
      mom = TrainingUtilities.flatten(pair[0].weights)
      dad = TrainingUtilities.flatten(pair[1].weights)
      offspring = breeder.mate(mom, dad)
      cattle << evaluate_candidate(TrainingUtilities.build_weights(offspring, inputs, shape))
    end

    thin_the_herd
  end

  def thin_the_herd
    cattle.sort! { |a,b| a.error <=> b.error }
    @cattle = cattle[0..(NUMBER_IN_HERD-1)]
  end

  def make_matches
    cattle.shuffle.each_slice(2).to_a
  end

  def build_intial_lifestock
    @cattle = []
    (NUMBER_IN_HERD).times do
      @cattle << evaluate_candidate(spawner.spawn)
    end
  end

  def spawner
    @spawner ||= Spawner.new(inputs, shape, WeightRandomizer.new)
  end

  def build_net(weights)
    NeuralNet.new(shape, weights)
  end

  def evaluate_candidate(weights)
    net = build_net(weights)
    squared_error_sum = 0.0
    training_data.each do |example|
      outputs = net.calculate(example.inputs)

      squared_error_sum += 1.0 unless correct_number?(outputs, example.expected)
    end

    Struct::Candidate.new(squared_error_sum/training_data.length, weights)
  end

  def correct_number?(expected, res)
    expected.each_with_index do |correct, i|
      if correct == 1.0
        return false if res[i] < 0.5
      else
        return false if res[i] > 0.5
      end
    end
    true
  end
end

