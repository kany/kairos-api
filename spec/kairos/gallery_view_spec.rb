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
  end

end