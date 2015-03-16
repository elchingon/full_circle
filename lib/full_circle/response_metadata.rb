require 'virtus'

module FullCircle
  class ResponseMetadata
    include Virtus.value_object

    values do
      attribute :page, Integer, default: 1
      attribute :results_per_page, Integer, default: 1
      attribute :total_results, Integer, default: 0
      attribute :total_pages, Integer, default: 0
    end

    def has_more_pages?
      page < total_pages
    end
  end
end
