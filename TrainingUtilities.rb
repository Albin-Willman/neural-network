class TrainingUtilities

  def self.flatten(weights)
    flat_array = []
    weights.each do |layer_weights|
      layer_weights.each do |node_weights|
        flat_array += node_weights
      end
    end
    flat_array
  end

  def self.build_weights(flat_array, inputs, shape)
    previous_nodes = inputs
    shape.map do |layer_nodes|
      layer_weights = build_layer_weights(previous_nodes, layer_nodes, flat_array)
      previous_nodes += layer_nodes
      layer_weights
    end
  end

  private

  def self.build_layer_weights(previous_nodes, layer_nodes, flat_array)
    layer_weights = []
    layer_nodes.times do |node|
      layer_weights << flat_array.shift(previous_nodes)
    end
    layer_weights
  end
end
