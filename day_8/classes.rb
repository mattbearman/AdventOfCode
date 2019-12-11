# frozen_string_literal: true

class String
  def chunk(length)
    scan(/.{#{length}}/)
  end
end

class SpaceImage
  attr_reader :raw_data, :width, :height
  attr_accessor :layers

  def initialize(raw_data:, width:, height:)
    @raw_data, @width, @height = raw_data.chomp, width, height
    create_layers
  end

  def create_layers
    self.layers = split_layers.map do | layer_data |
      Layer.new(raw_data: layer_data, width: width, height: height)
    end
  end

  def split_layers
    raw_data.chunk(area)
  end

  def area
    width * height
  end

  def layer_with_fewest(digit)
    layers.min do | a, b |
      a.digit_count(digit) <=> b.digit_count(digit)
    end
  end

  def render
    Layer.new(raw_data: combine_layers, width: width, height: height).render
  end

  def combine_layers
    combined_layers = nil

    layers.reverse.each do | layer |
      if combined_layers
        layer.raw_data.chars.each_with_index do | pixel, i |
          combined_layers[i] = pixel unless pixel.to_i == 2
        end
      else
        combined_layers = layer.raw_data
      end
    end

    combined_layers
  end
end

class SpaceImage
  class Layer
    attr_reader :raw_data, :width, :height
    
    def initialize(raw_data:, width:, height:)
      @raw_data, @width, @height = raw_data, width, height
    end

    def digit_count(digit)
      raw_data.to_i.digits.count(digit)
    end

    def render
      rasterise.map { | row | row.join }.join("\n")
    end

    def rasterise
      raw_data.chunk(width).map do | row |
        row.chars.map do | pixel |
          case pixel.to_i
          when 1
            "█"
          else
            " "
          end
        end
      end
    end
  end
end

# i = SpaceImage.new(raw_data: "123456789012", width: 3, height: 2)

# p i.layers[0].digit_count(0)
# p i.layers[1].digit_count(0)

# p i.layer_with_fewest(0)