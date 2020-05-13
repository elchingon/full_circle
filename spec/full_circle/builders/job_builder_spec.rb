require 'spec_helper'

module FullCircle
  describe Builders::JobBuilder do
    describe ".build" do
      it "returns a new Job object" do
        data = {
          "id"=>"17467",
          "jobField"=>"Customer Service",
          "educationRequirement"=>"N/A",
          "hoursType"=>"Part-Time",
          "title"=>"Barista | Durango, CO",
          "companyName"=>"Durango Joes Coffee",
          "companyAddr1"=>"779 Tech Center Drive",
          "companyCity"=>"Durango",
          "companyState"=>"CO",
          "companyZip"=>"81301",
          "displayStart"=>"2020-04-28",
          "displayEnd"=>"2021-04-01",
          "description"=> "At Durango Joes, we believe that everyone deserves a smile, a warm greeting, and a great cup of coffee. It is our honor to be a bright spot in the lives of our customers and we work hard to create lasting connections with our communities.\n\nWe believe in our employees and hire people who honestly care for others and train them to give the gift of legendary customer service with an amazing cup of coffee! Moreover, we encourage our baristas to have fun! And hope that each employee will grow as an individual while working for Durango Joes.\n\nTo echo the wisdom of a great leader, we have made it our aim to \"Be more concerned about making others feel good about themselves than making them feel good about us.\" - John Maxwell\n\nWe ONLY hire Baristas with great attitudes and who genuinely care about people and then we train the barista skills. Durango Joes Coffee is a growing company and provides an exciting and fun atmosphere to work in. We are committed to the personal growth and development of our employees as well as the communities in which we are a part.\n\n• Flexible schedules allow you to work shifts that fit your lifestyle.\n• Competitive compensation.\n• Drink, Food, and Merchandise discounts.\n• Plenty of room for advancement. We are always looking for staff who want to make a difference and grow with us.\n\nCome join the Durango Joes team and find out what it means to make a difference while serving delicious coffee.",
          "url"=>"https://360Durango.com/jobs/CustomerService/durango-joes-coffee/BaristaDurangoCO.html"
        }

        job = described_class.build data

        expected_job = Job.new id: 17467,
          title: "Barista | Durango, CO",
          job_field: "Customer Service",
          education_requirement: "N/A",
          hours_type:  "Part-Time",
          company_name: "Durango Joes Coffee",
          company_addr1: "779 Tech Center Drive",
          company_city: "Durango",
          company_state: "CO",
          company_zip: "81301",
          display_start: Date.new(2020,04,28),
          display_end: Date.new(2021,04,01),
          description: "At Durango Joes, we believe that everyone deserves a smile, a warm greeting, and a great cup of coffee. It is our honor to be a bright spot in the lives of our customers and we work hard to create lasting connections with our communities.\n\nWe believe in our employees and hire people who honestly care for others and train them to give the gift of legendary customer service with an amazing cup of coffee! Moreover, we encourage our baristas to have fun! And hope that each employee will grow as an individual while working for Durango Joes.\n\nTo echo the wisdom of a great leader, we have made it our aim to \"Be more concerned about making others feel good about themselves than making them feel good about us.\" - John Maxwell\n\nWe ONLY hire Baristas with great attitudes and who genuinely care about people and then we train the barista skills. Durango Joes Coffee is a growing company and provides an exciting and fun atmosphere to work in. We are committed to the personal growth and development of our employees as well as the communities in which we are a part.\n\n• Flexible schedules allow you to work shifts that fit your lifestyle.\n• Competitive compensation.\n• Drink, Food, and Merchandise discounts.\n• Plenty of room for advancement. We are always looking for staff who want to make a difference and grow with us.\n\nCome join the Durango Joes team and find out what it means to make a difference while serving delicious coffee.",
          url: "https://360Durango.com/jobs/CustomerService/durango-joes-coffee/BaristaDurangoCO.html"

        expect(job).to eq(expected_job)
      end

      it "returns a new Job object" do
        data = {
          "id"=>"17467",
          "jobField"=>"Customer Service",
          "educationRequirement"=>"N/A",
          "hoursType"=>"Part-Time",
          "title"=>"Barista | Durango, CO",
          "companyName"=>"Durango Joes Coffee",
          "companyAddr1"=>"779 Tech Center Drive",
          "companyCity"=>"Durango",
          "companyState"=>"CO",
          "companyZip"=>"81301",
          "displayStart"=>"2020-04-28",
          "displayEnd"=>"2021-04-01",
          "description"=>
           "At Durango Joes, we believe that everyone deserves a smile, a warm greeting, and a great cup of coffee.",
          "url"=>"https://360Durango.com/jobs/CustomerService/durango-joes-coffee/BaristaDurangoCO.html"
        }

        job = described_class.build data

        expected_job = Job.new id: 17467,
        title: "Barista | Durango, CO",
        job_field: "Customer Service",
        education_requirement: "N/A",
        hours_type:  "Part-Time",
        company_name: "Durango Joes Coffee",
        company_addr1: "779 Tech Center Drive",
        company_city: "Durango",
        company_state: "CO",
        company_zip: "81301",
        display_start: Date.new(2020,04,28),
        display_end: Date.new(2021,04,01),
        description: "At Durango Joes, we believe that everyone deserves a smile, a warm greeting, and a great cup of coffee.",
        url: "https://360Durango.com/jobs/CustomerService/durango-joes-coffee/BaristaDurangoCO.html"

        expect(job).to eq(expected_job)
      end
    end

  end
end
