module FullCircle
  class Builders::EventAreaBuilder
    def self.build(hash)
      EventArea.new(
        id: hash.fetch("id"),
        name: hash.fetch("name")
      )
    end
  end
end
