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
    expected = [1.6467558908171132, -31.37397886223291, 1.89676747423067]
    res = breeder.mate([1, 1, 1], [2, 2, 2])
    assert_equal(expected, res)
  end

  def test_mutation_can_occur
    parent = (1..7).to_a
    expected = [0.8967674742306699, 2, 3, 4, 5.378117436390945, 17.046751017840222, 7]
    res = breeder.mate(parent, parent)
    assert_equal(expected, res)
  end

  def breeder
    Breeder.new(1)
  end
end
