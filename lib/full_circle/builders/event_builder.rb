module FullCircle
  class Builders::EventBuilder
    def self.build(hash)
      Event.new(
        id: hash.fetch("id"),
        date: hash.fetch("date"),
        expire_date: hash["expireDate"],
        end_date: hash["endDate"],
        time: hash["time"],
        end_time: hash["endTime"],
        title: hash["title"],
        all_day_event: hash["allDayEvent"],
        times_vary: hash['times_vary'],
        location: hash['location'],
        type: hash['type'],
        date_mode: hash['dateMode'],
        site_id: hash['siteId'],
        price: hash['price'],
        link_text: hash['linkText'],
        link_url: hash['linkUrl'],
        featured: hash['featured'],
        description: hash['description'],
        image_url: hash['imageURL'],
        url: hash['url'],
      )
    end
  end
end
