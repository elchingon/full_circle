require "active_support/core_ext"

module FullCircle
  class API
  
    attr_reader :connection

    def initialize(connection)
      @connection=connection
    end

    def fetch_events_for_ad(id)
      response = connection.call_api_method("ad.getEvents", adId: id)
      ResponseParser.parse response
    end

    private
    class ResponseParser
      def self.parse(response)
        attrs = response.parsed_response
        event_attrs = Array.wrap(attrs["ad_getEventsResponse"]["events"]["event"])

        event_attrs.collect do |event_attr_set|
          Event.new(event_attr_set)
        end
      end
    end
  end
end
