module FullCircle
  class API

    attr_reader :connection

    def initialize(connection)
      @connection=connection
    end

    def fetch_events_for_ad(id)
      response = connection.call_api_method("ad.getEvents", adId: id)
      process_response(response)
    end

    def fetch_coupons_for_ad(id)
      response = connection.call_api_method("ad.getCoupons", adId: id)
      process_response(response)
    end

    def fetch_event_areas()
      response = connection.call_api_method("city.getEventAreas")
      process_response(response)
    end

    def fetch_upcoming_events(params={})
      response = connection.call_api_method("city.getUpcomingEvents", params)
      process_response(response, object_builder: UpcomingEventBuilder.new)
    end

    def all_ads

    end

    private

    def process_response(response, object_builder: ObjectBuilder.new)
      builder = ResponseBuilder.new
      response_object = builder.build response.results, object_builder: object_builder

      response_object.results
    end
  end
end
