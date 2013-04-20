require 'ostruct'

module FullCircle
  class ObjectBuilder

    # This class takes a hash from the api response and builds the appropriate
    # object.
    #
    #   cls - Class responding to initialize(hash) that takes a hash and sets
    #       its instance variables
    def initialize(cls=OpenStruct)
      @cls = cls
    end

    def from_api_hash(hash)

      @cls.new underscore_hash_keys(hash)
    end


    private
    def underscore_hash_keys(hash)
      result_hash ={}
      hash.keys.each do |key|
        result_hash[key.to_s.underscore] = hash[key]
      end
      result_hash
    end

  end
end
