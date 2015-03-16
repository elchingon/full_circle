require 'multi_xml'

module FullCircle
  class ResponseParser

    def initialize(data_extractor: Parsing::ResponseXMLDataExtractor.new)
      @data_extractor = data_extractor
    end

    def parse(xml_string)
      response_data = data_extractor.extract(xml_string)
    end


    private

    attr_reader :data_extractor


  end
end
