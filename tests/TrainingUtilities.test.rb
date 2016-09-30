require "minitest/autorun"

require_relative "../TrainingUtilities"

class TestTrainingUtilities < Minitest::Test

  def test_flatten_simple
    assert_equal([1,2], TrainingUtilities.flatten([[[1,2]]]))
  end

  def test_flatten_multi_layer
    assert_equal([1,2,3,4,5], TrainingUtilities.flatten([[[1,2]],[[3,4,5]]]))
  end

  def test_build_weghts_simple
    assert_equal([[[1,2]]], TrainingUtilities.build_weights([1,2], 2, [1]))
  end

  def test_build_weghts_layered
    assert_equal([[[1,2]],[[3,4,5]]], TrainingUtilities.build_weights([1,2,3,4,5], 2, [1,1]))
  end
end
