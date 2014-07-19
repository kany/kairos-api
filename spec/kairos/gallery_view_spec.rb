require 'spec_helper'

describe Kairos::Client do

  describe '#gallery_view' do
    before do
      @config = {
        :app_id          => 'abc1234',
        :app_key         => 'asdfadsfasdfasdfasdf'
      }
      @client = Kairos::Client.new(@config)
    end

    it 'responds to gallery_view' do
      @client.should respond_to(:gallery_view)
    end

    context 'with valid credentials' do
      before(:each) do
        VCR.use_cassette('gallery_view') do
          @response = @client.gallery_view(:gallery_name => 'testgallery')
        end
      end
      describe 'response' do
        it 'lists all subjects in gallery' do
          @response.should eq({"time"=>0.00287, "status"=>"Complete", "subject_ids"=>["gemtest", "gemtest", "gemtest", "gemtest", "gemtest", "gemtest"]})
        end
      end
    end
  end

end