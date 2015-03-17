module FullCircle
  class API

    attr_reader :connection

    def initialize(connection, response_parser: ResponseParser.new, results_per_page: 20)
      @connection=connection
      @response_parser = response_parser
      @results_per_page = results_per_page
    end

    def fetch_events_for_ad(id,params={})
      request_params = {page: 1, resultsPerPage: results_per_page, adId: id}.merge(params)
      response_xml = connection.call_api_method("ad.getEvents", request_params)
      response_parser.parse(response_xml).entities
    end

    def fetch_coupons_for_ad(id,params={})
      request_params = {page: 1, resultsPerPage: results_per_page, adId: id}.merge(params)
      response_xml = connection.call_api_method("ad.getCoupons", request_params)
      response_parser.parse(response_xml).entities
    end

    def fetch_event_areas(params={})
      request_params = {page: 1, resultsPerPage: results_per_page}.merge(params)
      response_xml = connection.call_api_method("city.getEventAreas", request_params)
      response_parser.parse(response_xml).entities
    end

    def fetch_upcoming_events(params={})
      request_params = {page: 1, resultsPerPage: results_per_page}.merge(params)
      response_xml = connection.call_api_method("city.getUpcomingEvents", params)
      response_parser.parse(response_xml, entity_builder: Builders::UpcomingEventBuilder)
        .entities
    end

    private

    attr_reader :response_parser, :results_per_page
  end
end
