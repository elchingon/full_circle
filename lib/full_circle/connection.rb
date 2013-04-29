module FullCircle
  class Connection

    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def base_uri
      "http://api.#{domain}/1.0/"
    end

    def call_api_method(method_name, query_params={})
      uri = URI("#{base_uri}#{method_name}?#{query_params.to_query}")
      response_text = Net::HTTP.get(uri)
      Response.new response_text
    end

    private
    Response = Struct.new(:body)
  end
end
