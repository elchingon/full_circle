module FullCircle
  class Builders::UpcomingEventBuilder

    def self.build(hash)
      result = Event.new({
        id: hash.fetch("id"),
        date: hash.fetch("date"),
        title: hash.fetch("title"),
        time: hash["time"],
        all_day_event: hash.fetch("allDayEvent"),
        date_mode: hash.fetch("dateMode"),
        site_id: hash.fetch("siteId"),
        type: hash.fetch("type"),
        location_url: hash['location_url'],
        image_url: hash.fetch("ad"){{}}.fetch("logoImage"){{}}["url"],
        end_date: hash["endDate"],
        price: hash["price"],
        link_text: hash["linkText"],
        link_url: hash["linkUrl"],
        featured: hash["featured"],
        expire_date: hash["expireDate"],
        end_time: hash["endTime"],
        description: hash["__content__"],
        ad_id: hash.fetch("ad"){{}}["id"]
      })
    end
  end
end
