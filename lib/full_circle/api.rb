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

  end
end
