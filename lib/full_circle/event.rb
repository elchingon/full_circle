module FullCircle
  class Event

    attr_reader :id, :title

    def initialize(attrs={})
      @id = attrs["id"]
      @title = attrs["title"]
    end
  end
end
