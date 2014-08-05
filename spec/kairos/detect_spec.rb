require 'spec_helper'

describe Kairos::Client do

  describe '#detect' do
    before do
      @config = {
        :app_id          => 'abc1234',
        :app_key         => 'asdfadsfasdfasdfasdf'
      }
      @client = Kairos::Client.new(@config)
    end

    it 'responds to detect' do
      @client.should respond_to(:detect)
    end

    context 'with valid credentials' do
      context 'with missing parameters' do
        it 'should not detect faces' do
          VCR.use_cassette('detect_with_missing_parameters') do
            response = @client.detect(:selector => 'FULL')
            response.should eq({"errors"=>[{"Errcode"=>5001, "Message"=>"some unknown service error"}]})
          end
        end
      end
      context 'with image with no faces' do
        it 'should not detect faces' do
          VCR.use_cassette('detect_with_no_faces_in_image') do
            response = @client.detect(:url => 'http://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Seal_of_the_US_Air_Force.svg/356px-Seal_of_the_US_Air_Force.svg.png', :selector => 'FULL')
            response.should eq({"errors"=>[{"Errcode"=>5002, "Message"=>"No face(s) found"}]})
          end
        end
      end
      context 'with required parameters' do
        before(:each) do
          VCR.use_cassette('detect') do
            @response = @client.detect(:url => 'http://www.history.com/s3static/video-thumbnails/AETN-History_Prod/24/226/History_First_Combat_By_Black_Pilots_Speech_SF_still_624x352.jpg', :selector => 'FULL')
          end
        end
        describe 'response' do
          it 'detects faces of Tuskegee Airman' do
            @response['images'][0]['status'].should eq("Complete")
            @response['images'][0]['faces'].size.should eq(3)
          end
        end
      end
    end
  end

end