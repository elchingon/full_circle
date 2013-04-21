require 'ostruct'
require 'multi_xml'

module FullCircle
  class ParsedResponse

    attr_reader :raw_xml

    def initialize(raw_xml)
      @raw_xml = raw_xml
    end

    def metadata
      @metadata ||= build_metadata
    end

    
    private

    def response_hash
      @response_hash ||= parsed_xml.fetch(parsed_xml.keys.first)
    end

    def parsed_xml
      @parsed_xml ||= MultiXml.parse(raw_xml)
    end

    def build_metadata
      OpenStruct.new( {
        page: Integer(response_hash.fetch("page"){1}),
        total_pages: Integer(response_hash.fetch("totalPages"){1}),
        total_results: Integer(response_hash.fetch("totalResults"){1}),
        results_per_page: Integer(response_hash.fetch("resultsPerPage"){1})
      })
    end
  end
end
