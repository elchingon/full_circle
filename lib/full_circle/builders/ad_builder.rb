module FullCircle::Builders
  class AdBuilder
    def self.build(hash)
      ad_hash={
        id: hash.fetch("id"),
        name: hash.fetch('name'),
        description: hash['description'],
        url: hash.fetch('url'),
        event_count: hash['eventCount'],
        coupon_count: hash['couponCount'],
        job_count: hash['jobCount'],
        location_count: hash['locationCount'],
        popup_count: hash['popupCount'],
        slideshow_count: hash['slideshowCount'],
        link_count: hash['linkCount']
      }

      if hash.has_key?("address")
        address_hash = hash["address"]
        ad_hash[:address]=FullCircle::Address.new({
          id: address_hash["id"],
          addr_1: address_hash["addr1"],
          city: address_hash["city"],
          state: address_hash["state"],
          zip_code: address_hash["zipCode"],
          phone: address_hash["phone"],
          latitude: address_hash["latitude"],
          longitude: address_hash["longitude"]
        })
      end

      FullCircle::Ad.new ad_hash
    end
  end
end
