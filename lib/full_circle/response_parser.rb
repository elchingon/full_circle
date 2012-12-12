module FullCircle
  class ResponseParser

    def self.parse(response)
      attrs = response.parsed_response

      if attrs["ad_getEventsResponse"]["events"].nil?
        []
      else
        event_attrs = Array.wrap(attrs["ad_getEventsResponse"]["events"]["event"])

        event_attrs.collect do |event_attr_set|
          Event.new(event_attr_set)
        end
      end
    end

  end
end
