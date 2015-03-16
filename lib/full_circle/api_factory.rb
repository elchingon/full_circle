module FullCircle
  class APIFactory

    def create(domain, cache: FullCircle::Connection::NullCache.new)
      connection = Connection.new(domain, cache: cache)
      API.new(connection)
    end
  end
end
