module FullCircle
  class Event
    include Virtus.value_object

    values do
      attribute :id, Integer
      attribute :date, Date
      attribute :end_date, Date
      attribute :expire_date, Date
      attribute :time, String
      attribute :end_time, String
      attribute :title, String
      attribute :all_day_event, Boolean
      attribute :times_vary, Boolean
      attribute :location, String
      attribute :type, String
      attribute :date_mode, Integer
      attribute :site_id, Integer
      attribute :price, String
      attribute :link_text, String
      attribute :link_url, String
      attribute :featured, Boolean
      attribute :description, String
      attribute :image_url, String
      attribute :url, String
      attribute :ad_id, Integer
    end
  end
end
