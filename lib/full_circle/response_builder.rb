module FullCircle
  # @api private
  class ResponseBuilder
    def build(api_results, object_builder: ObjectBuilder.new)
      objects = objects_from_api_hashes(api_results, object_builder)

      Response.new(objects)
    end

    private

    def objects_from_api_hashes(api_results, object_builder)
      api_results.map do |result|
        object_builder.from_api_hash(result)
      end
    end
  end
end
