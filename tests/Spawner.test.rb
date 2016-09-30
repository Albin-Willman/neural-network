require "minitest/autorun"

require_relative "../Spawner"

class TestNeuralNet < Minitest::Test

  def test_constructor
    assert(spawner(1, [1]).is_a?(Spawner))
  end

  def test_spawn_simple
    expected = [[[1]]]
    res = spawner(1, [1]).spawn
    assert_equal(expected, res)
  end


  def spawner(inputs, shape)
    Spawner.new(inputs, shape, DummyRandom.new)
  end
end

class DummyRandom
  def rand
    1
  end
end
