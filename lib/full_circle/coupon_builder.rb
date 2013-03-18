module FullCircle
  class CouponBuilder

    def self.from_api_hash(hash)

      Coupon.new underscore_hash_keys(hash)
    end


    private
    def self.underscore_hash_keys(hash)
      result_hash ={}
      hash.keys.each do |key|
        result_hash[key.to_s.underscore] = hash[key]
      end
      result_hash
    end

  end
end
