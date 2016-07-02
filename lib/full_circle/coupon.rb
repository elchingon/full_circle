require 'virtus'

class FullCircle::Coupon
  include Virtus.value_object

  values do
    attribute :id, Integer
    attribute :name, String
    attribute :begin, Date
    attribute :expire, Date
    attribute :accept_offline, Boolean
    attribute :accept_online, Boolean
    attribute :accept_mobile, Boolean
    attribute :accept_print, Boolean
    attribute :offer, String
    attribute :restrictions, String
    attribute :url, String
    attribute :regular_url, String
    attribute :ad_name, String
    attribute :directory_url, String
    attribute :phone, String
    attribute :location_url, String
  end
end
