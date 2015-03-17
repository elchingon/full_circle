module FullCircle
  class EndpointIterator
    include Enumerable

    def initialize(api_client, method_name, request_params={})
      @api_client = api_client
      @method_name = method_name
      @request_params = request_params
      @page_limit = 100_000 #100,000 pages should be more than enough.
    end

    def each
      1.upto(page_limit) do |i|
        results = call_api_client_method_for_page(i)
        results.each do |result|
          yield result
        end
        break unless results.has_more_pages?
      end
    end

    private

    attr_accessor :api_client, :method_name, :request_params, :page_limit

    def call_api_client_method_for_page(page_number)
      params = params_for_page(page_number)
      api_client.public_send(method_name, params)
    end

    def params_for_page(page_number)
      request_params.merge(page: page_number)
    end
  end
end
