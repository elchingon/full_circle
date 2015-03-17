require 'virtus'

module FullCircle
  class Address
    include Virtus.value_object

    values do
      attribute :id, Integer
      attribute :addr_1, String
      attribute :city, String
      attribute :state, String
      attribute :zip, String
      attribute :phone, String
      attribute :latitude, Float
      attribute :longitude, Float
    end
  end
end
