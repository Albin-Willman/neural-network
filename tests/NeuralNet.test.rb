require "minitest/autorun"

require_relative "../NeuralNet"

class TestNeuralNet < Minitest::Test

  def test_constructor
    assert(NeuralNet.new([1], [1]).is_a?(NeuralNet))
  end

  def test_no_hidden_nodes
    net = NeuralNet.new([1], [[[1,1]]])
    assert_equal([0.8807970779778823], net.calculate([1, 1]))
  end

  def test_one_hidden_layer
    net = NeuralNet.new([2, 1], [[ [1,1], [1,1]], [[0, 0, 1, 1]]])
    assert_equal([0.8534092045709026], net.calculate([1, 1]))
  end
end
