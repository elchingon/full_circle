module FullCircle
  class ResponseParser

    attr_reader :api_method_name, :object_name

    def initialize(api_method_name, object_name)
      @api_method_name= api_method_name
      @object_name = object_name
    end

    def parse(response)
      if response
        attrs = response.parsed_response

        parse_response(attrs, response_name, object_name)
      end
    end




    private

    # example
    # parseResponse(attrs, "city_getEventAreasResponse", "eventArea")
    def parse_response(attrs, response_name, object_name)
      if attrs[response_name][object_name.pluralize].nil?
        []
      else
        response_attrs = Array.wrap(attrs[response_name][object_name.pluralize][object_name])

        builder = ObjectBuilder.new
        response_attrs.collect do |response_attr_set|
          builder.from_api_hash(response_attr_set)
        end
      end
    end
    
    def response_name
      @response_name ||= "#{api_method_name.gsub(/\./,'_')}Response"
    end

  end
end
