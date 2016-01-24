require 'multi_xml'

module FullCircle
  class ResponseParser

    def initialize(data_extractor: Parsing::ResponseXMLDataExtractor.new)
      @data_extractor = data_extractor
    end

    def parse(xml_string, entity_builder: nil)
      if xml_string.empty?
        Response.new([], FullCircle::ResponseMetadata.new)
      else

        extractor_response = data_extractor.extract(xml_string)

        if extractor_response.entities.any?
          if entity_builder.nil?
            entity_builder = entity_builder_for_key(extractor_response.entity_key)
          end

          entities = extractor_response.entities.map do |entity_hash|
            entity_builder.build(entity_hash)
          end

          Response.new(entities, extractor_response.metadata)
        else
          Response.new([], extractor_response.metadata)
        end
      end
    end

    private

    attr_reader :data_extractor

    def entity_builder_for_key(entity_key)
      case entity_key
      when "ad"
        Builders::AdBuilder
      when "coupon"
        Builders::CouponBuilder
      when "event"
        Builders::EventBuilder
      when "eventArea"
        Builders::EventAreaBuilder
      else
        raise "Unknown builder for key #{entity_key}"
      end
    end
  end
end
