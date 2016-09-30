require 'csv'
require_relative './Trainer'
class DataReader
  EXPECTED_SIZE = 28
  WANTED_SIZE = 24
  def run(file_path, n = 100)
    data = []
    CSV.foreach(file_path).with_index do |row, i|
      next if i == 0
      return data if i > n
      data << build_trainable_data(row)
    end
    data
  end

  private
  def build_trainable_data(row)
    Struct::Example.new(integer_to_binary_arr(row.shift), extract_middle(row.map(&:to_f)))
  end

  def extract_middle(image)
    border = (EXPECTED_SIZE - WANTED_SIZE)/2
    res = []
    WANTED_SIZE.times do |i|
      WANTED_SIZE.times do |j|
        res << image[(i+border)*EXPECTED_SIZE + j + border]
      end
    end
    res
  end

  def integer_to_binary_arr(i)
    ("%04b" % i).split("").map(&:to_i)
  end
end