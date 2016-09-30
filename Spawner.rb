class Spawner
  attr_accessor :inputs, :random, :shape, :previous_nodes
  def initialize(inputs, shape, random)
    @random = random
    @shape = shape
    @inputs = inputs
  end

  def spawn
    @previous_nodes = inputs
    shape.map do |layer_nodes|
      layer = build_layer(layer_nodes)
      @previous_nodes += layer_nodes
      layer
    end
  end

  private

  def build_layer(layer_nodes)
    layer = []
    layer_nodes.times do
      layer << build_node_weights
    end
    layer
  end

  def build_node_weights
    weights = []
    previous_nodes.times do
      weights << random.rand
    end
    weights
  end
end

class WeightRandomizer
  attr_accessor :random
  def initialize(seed = nil)
    @random = seed ? Random.new(seed) : Random.new
  end

  def rand
    (random.rand - 0.5) * 10
  end
end
