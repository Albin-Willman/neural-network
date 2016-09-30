require "minitest/autorun"

require_relative "../Breeder"

class TestBreeder < Minitest::Test

  def test_constructor
    assert(breeder.is_a?(Breeder))
  end

  def test_mate_different_length
    begin
      breeder.mate([1], [1, 2])
      assert(false)
    rescue LengthMissmatchError => e
      assert(true)
    else
      assert(false)
    end
  end

  def test_mate_length_three_arrays
    expected = [2, 1, 2]
    res = breeder.mate([1, 1, 1], [2, 2, 2])
    assert_equal(expected, res)
  end

  def test_mutation_can_occur
    parent = (1..200).to_a
    expected = parent.clone
    expected[50] = 72.94414980175213
    res = breeder.mate(parent, parent)
    assert_equal(expected, res)
  end

  def breeder
    Breeder.new(1)
  end
end
