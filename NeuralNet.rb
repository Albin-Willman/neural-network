require 'matrix'
class NeuralNet
  attr_accessor :weights, :previous_values, :shape
  def initialize(shape, weights)
    @weights = weights
    @shape = shape
  end

  def calculate(inputs)
    @previous_values = inputs
    shape.each_with_index do |nodes_in_level, level|
      calculate_level(nodes_in_level, level)
    end
    @previous_values[-(shape.last)..-1]
  end

  private

  def calculate_level(nodes_in_level, level)
    level_values = []
    nodes_in_level.times do |node_index|
      level_values << NeuralNode.new(previous_values, weights[level][node_index]).value
    end
    @previous_values += level_values
  end
end

class NeuralNode
  attr_accessor :value

  def initialize(inputs, weights)
    @value = sigmoid(Vector::elements(inputs).inner_product(Vector::elements(weights)))
  end

  def sigmoid(x)
      1 / (1 + Math.exp(-x))
    end
end
