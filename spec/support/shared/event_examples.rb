shared_examples_for "an event" do
  required_attrs = :id, :date, :time, :title, :all_day_event, :date_mode, :site_id,
    :type, :description

  required_attrs.each do |field|
    it "does not have a blank #{field}" do
      expect(subject.send("#{field}")).to be_present
    end
  end


end
