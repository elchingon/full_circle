module FullCircle
  class API

    attr_reader :connection

    def initialize(connection)
      @connection=connection
    end

    def fetch_events_for_ad(id)
      response = connection.call_api_method("ad.getEvents", adId: id)
      pr = ParsedResponse.new(response.body)
      builder = ResponseBuilder.new pr.results, metadata: pr.metadata
      builder.build.results
    end

    def fetch_coupons_for_ad(id)
      response = connection.call_api_method("ad.getCoupons", adId: id)
      pr = ParsedResponse.new(response.body)
      builder = ResponseBuilder.new pr.results, metadata: pr.metadata
      builder.build.results
    end

    def fetch_event_areas()
      response = connection.call_api_method("city.getEventAreas")
      pr = ParsedResponse.new(response.body)
      builder = ResponseBuilder.new pr.results, metadata: pr.metadata
      builder.build.results
    end

    def fetch_upcoming_events(params={})
      response = connection.call_api_method("city.getUpcomingEvents", params)
      pr = ParsedResponse.new(response.body)
      builder = ResponseBuilder.new pr.results, metadata: pr.metadata, object_builder: UpcomingEventBuilder.new
      builder.build.results
    end
  end
end
