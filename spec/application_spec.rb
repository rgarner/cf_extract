require 'spec_helper'

describe "Awards by quarter app" do
  include_examples "Test awards"

  def app
    @app ||= Sinatra::Application
  end

  describe "/years/" do
    before do
      save_awards
      get '/years'
    end

    specify { last_response.status.should == 200 }
    it "should have both years" do
      last_response.body.should have_selector(".year", count: 2)
    end

    describe ".json" do
      before { get '/years.json' }
      specify { last_response.body.should include('"award_count":1') }
    end
  end

  describe "/years/:year" do
    before do
      save_awards
      get '/years/2012'
    end

    specify { last_response.status.should == 200 }
    it "should have at least one quarter" do
      last_response.body.should have_selector(".quarter")
    end
    it "should have at least one award in each quarter" do
      last_response.body.should have_selector(".quarter .award")
    end
  end
end
