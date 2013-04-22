module FullCircle
  class ResponseBuilder

    attr_reader :api_results, :metadata, :object_builder

    # Creates a new response builder
    # api_results - collection of objects to be built into the response
    # args
    #   metadata: hash of metadata 
    #   object_builder: The object builder to use for building api objects
    def initialize(api_results, args={})
      @api_results = api_results
      @metadata = args.fetch(:metadata){{}}
      @object_builder = args.fetch(:object_builder){ObjectBuilder.new}
    end

    def build
      objects = api_results.map do |result|
        object_builder.from_api_hash(result)
      end

      Response.new(objects,metadata)
    end
    
  end
end
