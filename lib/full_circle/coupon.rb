require 'virtus'

class FullCircle::Coupon
  include Virtus.value_object

  values do
    attribute :id, Integer
    attribute :name, String
    attribute :path_segment, String
    attribute :begin, Date
    attribute :expire, Date
    attribute :accept_offline, Boolean
    attribute :accept_online, Boolean
    attribute :accept_mobile, Boolean
    attribute :accept_print, Boolean
    attribute :offer, String
    attribute :restrictions, String
  end
end
