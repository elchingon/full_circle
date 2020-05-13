module FullCircle
  class Builders::JobBuilder
    def self.build(hash)
      job = Job.new(
        id: hash.fetch("id"),
        title: hash.fetch("title"),
        job_field: hash['jobField'],
        education_requirement: hash['educationRequirement'],
        company_name: hash['companyName'],
        company_addr1: hash['companyAddr1'],
        company_city: hash['companyCity'],
        company_state: hash['companyState'],
        accept_print: hash['acceptPrint'],
        company_zip: hash['companyZip'],
        salary: hash['salary'],
        hours_type: hash['hoursType'],
        display_start: hash['displayStart'],
        display_end: hash['displayEnd'],
        description: hash['description'],
        contact_name: hash['contactName'],
        contact_email: hash['contactEmail'],
        contact_phone: hash['contactPhone'],
        contact_fax: hash['contactFax'],
        url: hash['url']
      )
    end
  end
end
