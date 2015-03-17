module FullCircle::Parsing
  class ResponseXMLDataExtractor

    def extract(raw_xml)
      parsed_xml = parse_xml(raw_xml)

      if is_error_response?(parsed_xml)
        metadata = FullCircle::ResponseMetadata.new page: 1,
          results_per_page: 0, total_pages: 0, total_results: 0

        Response.new([], nil,  metadata)
      else
        results_array = get_results_array(parsed_xml)
        entity_key = get_entity_key(parsed_xml)
        metadata = get_metadata(parsed_xml, results_array)

        Response.new(results_array, entity_key, metadata)
      end
    end

    private

    def parse_xml(raw_xml)
      MultiXml.parse(raw_xml)
    end

    def is_error_response?(parsed_xml)
      parsed_xml.has_key?("errorResponse")
    end

    def get_results_array(parsed_xml)
      response_wrapper_hash = get_response_wrapper_hash(parsed_xml)

      collection_wrapper_hash = get_collection_wrapper_hash(response_wrapper_hash)

      entities_array = get_entities_array(collection_wrapper_hash)

      clean_up_entities_array(entities_array)
    end

    def get_entity_key(parsed_xml)
      response_wrapper_hash = get_response_wrapper_hash(parsed_xml)

      entity_key = find_enumerable_hash_key(response_wrapper_hash)

      if entity_key.nil?
        entity_key = response_wrapper_hash.key(nil)
      end

      entity_key.singularize
    end

    def get_metadata(parsed_xml, results)
      response_wrapper_hash = get_response_wrapper_hash(parsed_xml)

      FullCircle::ResponseMetadata.new(
        page: response_wrapper_hash.fetch("page"){1},
        total_pages: response_wrapper_hash.fetch("totalPages"){1},
        total_results: response_wrapper_hash.fetch("totalResults"){results.length},
        results_per_page: response_wrapper_hash.fetch("resultsPerPage"){results.length}
      )
    end

    def get_collection_wrapper_hash(response_wrapper_hash)
      enumerable_hash_key = find_enumerable_hash_key(response_wrapper_hash)

      response_wrapper_hash.fetch(enumerable_hash_key, {})
    end

    def get_entities_array(collection_wrapper_hash)
      enumerable_hash_key = find_enumerable_hash_key(collection_wrapper_hash)

      result = collection_wrapper_hash.fetch(enumerable_hash_key, [])
      Array.wrap(result);
    end

    def clean_up_entities_array(entities_array)
      entities_array.each do |entity_hash|
        if entity_hash["__content__"].blank?
          entity_hash.delete("__content__")
        end
      end
    end



    def get_response_wrapper_hash(parsed_xml)
      parsed_xml.fetch(parsed_xml.keys.first)
    end

    def find_enumerable_hash_key(hash)
      hash.map {|k,v| k if v.kind_of? Enumerable }.reject{|k| k.nil?}.first
    end

    Response = Struct.new(:entities, :entity_key, :metadata)
  end
end
