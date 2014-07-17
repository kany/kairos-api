require 'spec_helper'

describe Kairos::Client do

  context "when working with the Enroll endpoint" do
    before do
      @client = Kairos::Client.new(:app_id => "consumerid", :app_key => "consumersecret")
    end

    describe "'Enroll'" do
      context "with image url" do
        it "should return a json response with completed enrollment information" do
          pending
        end
      end
    end
  end

end