require 'spec_helper'

describe Kairos::Client do

  describe '#gallery_list_all' do
    before do
      @config = {
        :app_id          => 'abc1234',
        :app_key         => 'asdfadsfasdfasdfasdf'
      }
      @client = Kairos::Client.new(@config)
    end

    it 'responds to gallery_list_all' do
      @client.should respond_to(:gallery_list_all)
    end

    context 'with valid credentials' do
      before(:each) do
        VCR.use_cassette('gallery_list_all') do
          @response = @client.gallery_list_all
        end
      end
      describe 'response' do
        it 'lists all galleries' do
          @response.should eq({"time"=>0.00189, "status"=>"Complete", "gallery_ids"=>['testgallery']})
        end
      end
    end
  end

end