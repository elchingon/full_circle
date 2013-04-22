module FullCircle
  class Response
    attr_reader :results, :page, :total_pages, :total_results, :results_per_page
    
    def initialize(results, metadata)
      @results = results
      @page = metadata.fetch(:page){1}
      @total_pages = metadata.fetch(:total_pages){1}
      @total_results = metadata.fetch(:total_results){results.length}
      @results_per_page = metadata.fetch(:results_per_page){results.length}
    end

  end
end
