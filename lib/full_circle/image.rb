require 'virtus'

module FullCircle
  class Image
    include Virtus.value_object

    values do
      attribute :url, String
      attribute :width, Integer
      attribute :height, Integer
    end
  end
end