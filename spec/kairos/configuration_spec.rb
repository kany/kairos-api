require 'spec_helper'

describe Kairos::Configuration do

  after do
    Kairos.reset
  end

  describe '.configure' do
    Kairos::Configuration::VALID_CONFIG_KEYS.each do |key|
      it "should set the #{key}" do 
        Kairos.configure do |config|
          config.send("#{key}=", key)
          Kairos.send(key).should eq(key)
        end
      end
    end
  end

  Kairos::Configuration::VALID_CONFIG_KEYS.each do |key|
    describe ".#{key}" do
      it 'should return the default value' do
        Kairos.send(key).should eq( Kairos::Configuration.const_get("DEFAULT_#{key.upcase}") )
      end
    end
  end

end