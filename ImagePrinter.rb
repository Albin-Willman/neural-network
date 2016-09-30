class ImagePrinter
  def run(image_data)
    size = Math.sqrt(image_data.length).to_i
    size.times do |i|
      row = ''
      size.times do |j|
        row << (image_data[i*size + j] > 0.0 ? 'I' : ' ')
      end
      puts row
    end
  end
end
