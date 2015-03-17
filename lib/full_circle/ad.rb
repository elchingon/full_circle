require 'virtus'

module FullCircle
  class Ad
    include Virtus.value_object

    values do
      attribute :id, Integer
      attribute :url, String
      attribute :event_count, Integer
      attribute :coupon_count, Integer
      attribute :job_count, Integer
      attribute :location_count, Integer
      attribute :popup_count, Integer
      attribute :slideshow_count, Integer
      attribute :link_count, Integer
      attribute :address, FullCircle::Address
    end
  end
end
