module FullCircle
  # @api private
  class ResponseBuilder
    def build(api_results, object_builder: ObjectBuilder.new)
      objects = api_results.map do |result|
        object_builder.from_api_hash(result)
      end

      Response.new(objects)
    end
  end
end
