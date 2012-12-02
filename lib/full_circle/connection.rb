module FullCircle
  class Connection

    attr_reader :domain

    def initialize(domain)
      @domain = domain
    end

    def base_uri
      "http://api.#{domain}/1.0/"
    end

  end
end
