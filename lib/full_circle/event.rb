module FullCircle
  class Event

    ATTRS = [:id, :title, :date, :end_date, :time, :end_time, :all_day_event, :location,
    :type, :date_mode, :site_id, :link_text, :link_url, :featured, :description, :image_url]
    
    attr_reader *ATTRS

    def initialize(attrs={})
      assign_instance_variables attrs
    end

    private

    def assign_instance_variables(attrs)
      attrs = attrs.with_indifferent_access

      ATTRS.each do |attr_name|
        instance_variable_set("@#{attr_name}".to_sym, attrs[attr_name])
      end
    end
  end
end
