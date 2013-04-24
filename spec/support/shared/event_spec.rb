shared_examples_for "an event" do
  required_attrs = :id, :date, :time, :title, :all_day_event, :date_mode, :site_id,
    :type, :description

  for attr in required_attrs
    its(attr){should_not be_blank}
  end


end
