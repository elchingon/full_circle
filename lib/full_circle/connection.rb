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
      HTTParty.get(method_name,base_uri: base_uri, query: query_params) 
    end
  end
end
