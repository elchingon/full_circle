require 'ostruct'

module FullCircle
  class UpcomingEventBuilder
    def initialize
      @domain = "360durango.com"
    end

    def from_api_hash(hash)
      @hash = hash
      result = OpenStruct.new({
        id: hash.fetch("id"),
        date: hash.fetch("date"),
        title: hash.fetch("title"),
        time: hash.fetch("time"),
        all_day_event: hash.fetch("allDayEvent"),
        date_mode: hash.fetch("dateMode"),
        site_id: hash.fetch("siteId"),
        image_url: "http://tours.#{domain}/#{ad_id}/event_#{event_id}.jpg",
        type: hash.fetch("type"),

        end_date: hash["endDate"],
        expire_date: hash["expireDate"],
        end_time: hash["endTime"],
        description: hash["__content__"],
        ad_id: ad_id,
      })
    end


    private
    attr_reader :hash
    attr_reader :domain

    def event_id
      hash.fetch("id")
    end

    def ad_id
      hash.fetch("ad"){{}}["id"]
    end
      
  end
end
