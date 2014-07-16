require 'spec_helper'

describe Kairos::Client do

  before do
    @keys = Kairos::Configuration::VALID_CONFIG_KEYS
  end

  describe 'with module configuration' do
    before do
      Kairos.configure do |config|
        @keys.each do |key|
          config.send("#{key}=", key)
        end
      end
    end

    after do
      Kairos.reset
    end

    it "should inherit module configuration" do
      api = Kairos::Client.new
      @keys.each do |key|
        api.send(key).should eq(key)
      end
    end

    describe 'with class configuration' do
      before do
        @config = {
          :app_id          => 'zz',
          :api_key         => 'ak',
          :url             => 'of',
          :subject_id      => 'ep',
          :gallery_name    => 'ua',
          :threshold       => 'hm',
          :max_num_results => 'bc',
          :selector        => 'uy'
        }
      end

      it 'should override module configuration' do
        api = Kairos::Client.new(@config)
        @keys.each do |key|
          api.send(key).should eq(@config[key])
        end
      end

      it 'should override module configuration after' do
        api = Kairos::Client.new

        @config.each do |key, value|
          api.send("#{key}=", value)
        end

        @keys.each do |key|
          api.send("#{key}").should eq(@config[key])
        end
      end

    end

  end

end