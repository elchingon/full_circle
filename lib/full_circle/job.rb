require 'virtus'

class FullCircle::Job
  include Virtus.value_object

  values do
    attribute :id, Integer
    attribute :title, String
    attribute :job_field, String
    attribute :education_requirement, String
    attribute :company_name, String
    attribute :company_addr1, String
    attribute :company_city, String
    attribute :company_state, String
    attribute :company_zip, String
    attribute :accept_print, Boolean
    attribute :salary, String
    attribute :hours_type, String
    attribute :display_start, Date
    attribute :display_end, Date
    attribute :description, String
    attribute :contact_name, String
    attribute :contact_email, String
    attribute :contact_phone, String
    attribute :contact_fax, String
    attribute :url, String
   
  end
end
