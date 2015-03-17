module FullCircle
  class Response
    attr_reader :entities, :metadata

    def initialize(entities, metadata)
      @entities = entities
      @metadata = metadata
    end

  end
end
