module FullCircle
  class API

    attr_reader :connection

    def initialize(connection, response_parser: ResponseParser.new)
      @connection=connection
      @response_parser = response_parser
    end

    def fetch_events_for_ad(id)
      response_xml = connection.call_api_method("ad.getEvents", adId: id)
      response_parser.parse(response_xml).entities
    end

    def fetch_coupons_for_ad(id)
      response_xml = connection.call_api_method("ad.getCoupons", adId: id)
      response_parser.parse(response_xml).entities
    end

    def fetch_event_areas()
      response_xml = connection.call_api_method("city.getEventAreas")
      response_parser.parse(response_xml).entities
    end

    def fetch_upcoming_events(params={})
      response_xml = connection.call_api_method("city.getUpcomingEvents", params)
      response_parser.parse(response_xml, entity_builder: Builders::UpcomingEventBuilder)
        .entities
    end

    private

    attr_reader :response_parser
  end
end
