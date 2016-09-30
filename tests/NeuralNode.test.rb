require "minitest/autorun"

require_relative "../NeuralNet"

class TestNeuralNode < Minitest::Test

  def test_constructor
    assert(NeuralNode.new([1], [1]).is_a?(NeuralNode))
  end

  def test_one_length_array
    assert_equal(NeuralNode.new([1], [1]).value, 1)
  end

  def test_three_length_array
    assert_equal(NeuralNode.new([1,2,3], [3,2,1]).value, 10)
  end
end
