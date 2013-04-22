require 'spec_helper'

describe FullCircle::Response do

  describe "defaults" do
    subject{described_class.new([],{})}

    its(:results){should eq []}
    its(:page){should eq 1}
    its(:total_pages){should eq 1}
    its(:results_per_page){should eq 0 }
    its(:total_results){should eq 0 }

  end

  describe "with metadata" do
    subject{described_class.new([],{page: 2, total_pages:5, results_per_page: 5, total_results: 25})}

    its(:results){should eq []}
    its(:page){should eq 2}
    its(:total_pages){should eq 5}
    its(:results_per_page){should eq 5 }
    its(:total_results){should eq 25 }

  end



end
