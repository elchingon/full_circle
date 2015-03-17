require 'forwardable'

module FullCircle
  class Response
    extend Forwardable
    include Enumerable

    def_delegators :results, :each, :length
    def_delegators :metadata, :page, :total_pages, :results_per_page,
      :total_results, :has_more_pages?

    attr_reader :results, :metadata

    def initialize(results, metadata)
      @results = results
      @metadata = metadata
    end

  end
end
