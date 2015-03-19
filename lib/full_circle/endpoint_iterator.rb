module FullCircle
  class EndpointIterator
    include Enumerable
    extend Forwardable

    def initialize(*args)
      @arg_parser = ArgParser.new args
      @api_client = arg_parser.api_client
      @method_name = arg_parser.method_name
      @request_params = arg_parser.request_params
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

    attr_reader :arg_parser, :page_limit
    def_delegators :arg_parser, :api_client, :method_name, :request_params, :additional_positional_args

    def call_api_client_method_for_page(page_number)
      params = params_for_page(page_number)
      api_client.public_send(method_name, *additional_positional_args,  params)
    end

    def params_for_page(page_number)
      request_params.merge(page: page_number)
    end

    class ArgParser

      attr_reader :api_client, :method_name, :request_params, :additional_positional_args

      def initialize(args)
        my_args = args.clone

        @api_client, @method_name = my_args.shift(2)

        if my_args.last.is_a? Hash
          @request_params = my_args.pop
        else
          @request_params = {}
        end

        @additional_positional_args = my_args
      end
    end
  end
end
