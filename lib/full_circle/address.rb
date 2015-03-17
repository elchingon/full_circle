require 'virtus'

module FullCircle
  class Address
    include Virtus.value_object

    values do
      attribute :addr_1, String
      attribute :city, String
      attribute :state, String
      attribute :zip, String
    end
  end
end
