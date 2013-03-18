module FullCircle
  class ResponseParser

    def self.parse(response)
      attrs = response.parsed_response

      # TODO this could be much better. Maybe have individual parsers that are called
      # based on a specific key like "events". This is a good gist for an idea of how
      # to search deeply in nested hashes: https://gist.github.com/58257
      
      if attrs.has_key? "ad_getEventsResponse"
        if attrs["ad_getEventsResponse"]["events"].nil?
          []
        else
          event_attrs = Array.wrap(attrs["ad_getEventsResponse"]["events"]["event"])

          event_attrs.collect do |event_attr_set|
            EventBuilder.from_api_hash(event_attr_set)
          end
        end
      elsif attrs.has_key? "ad_getCouponsResponse"
        if attrs["ad_getCouponsResponse"]["coupons"].nil?
          []
        else
          coupon_attrs = Array.wrap(attrs["ad_getCouponsResponse"]["coupons"]["coupon"])

          coupon_attrs.collect do |coupon_attr_set|
            CouponBuilder.from_api_hash(coupon_attr_set)
          end
        end
      end
    end

  end
end
