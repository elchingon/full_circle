module FullCircle
  class API
  
    attr_reader :connection

    def initialize(connection)
      @connection=connection
    end

    def fetch_events_for_ad(id)
      parser = ResponseParser.new 
      response = connection.call_api_method("ad.getEvents", adId: id)
      parser.parse response
    end

    def fetch_coupons_for_ad(id)
      parser = ResponseParser.new 
      response = connection.call_api_method("ad.getCoupons", adId: id)
      parser.parse response
    end

    def fetch_event_areas
      parser = ResponseParser.new 
      response = connection.call_api_method("city.getEventAreas")
      parser.parse response
    end
  end
end
