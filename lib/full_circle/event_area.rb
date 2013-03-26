module FullCircle
  class EventArea

    ATTRS = [:id, :name]
    
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
