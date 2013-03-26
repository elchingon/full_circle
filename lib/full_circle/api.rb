module FullCircle
  class API
  
    attr_reader :connection

    def initialize(connection)
      @connection=connection
    end

    def fetch_events_for_ad(id)
      parser = ResponseParser.new "ad.getEvents", "event"
      response = connection.call_api_method("ad.getEvents", adId: id)
      parser.parse response
    end

    def fetch_coupons_for_ad(id)
      parser = ResponseParser.new "ad.getCoupons", "coupon"
      response = connection.call_api_method("ad.getCoupons", adId: id)
      parser.parse response
    end

    def fetch_event_areas
      parser = ResponseParser.new "city.getEventAreas", "eventArea"
      response = connection.call_api_method("city.getEventAreas")
      parser.parse response
    end

    def fetch_upcoming_events
      parser = ResponseParser.new "city.getUpcomingEvents", "event"
      response = connection.call_api_method("city.getUpcomingEvents")
      parser.parse response
    end
  end
end
