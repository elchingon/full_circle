module FullCircle
  class ResponseParser

    # TODO: Refactor this into an instance method
    def self.parse(response)
      attrs = response.parsed_response

      # TODO this could be much better. Maybe have individual parsers that are called
      # based on a specific key like "events". This is a good gist for an idea of how
      # to search deeply in nested hashes: https://gist.github.com/58257
      
      if attrs.has_key? "ad_getEventsResponse"
        self.parse_response(attrs, "ad_getEventsResponse", "event")
      elsif attrs.has_key? "ad_getCouponsResponse"
        self.parse_response(attrs, "ad_getCouponsResponse", "coupon")
      elsif attrs.has_key? "city_getEventAreasResponse"
        self.parse_response(attrs, "city_getEventAreasResponse", "eventArea")
      end
    end


    private

    # example
    # parseResponse(attrs, "city_getEventAreasResponse", "eventArea")
    def self.parse_response(attrs, response_name, object_name)
      if attrs[response_name][object_name.pluralize].nil?
        []
      else
        response_attrs = Array.wrap(attrs[response_name][object_name.pluralize][object_name])

        builder = ObjectBuilder.new("FullCircle::#{object_name.camelize}".constantize)
        response_attrs.collect do |response_attr_set|
          builder.from_api_hash(response_attr_set)
        end
      end
    end
  end
end
