require 'spec_helper'

describe Kairos::Client do

  describe '#recognize' do
    before do
      @config = {
        :app_id          => 'abc1234',
        :app_key         => 'asdfadsfasdfasdfasdf'
      }
      @client = Kairos::Client.new(@config)
    end

    it 'responds to recognize' do
      @client.should respond_to(:recognize)
    end

    context 'with valid credentials' do
      context 'with missing parameters' do
        it 'should not recognize an image' do
          VCR.use_cassette('recognize_with_missing_parameters') do
            response = @client.recognize(:url => 'https://some.image.url/123abc.jpg')
            response.should eq({"images"=>[{"status"=>"failure", "message"=>{"errors"=>{"gallery_id"=>"gallery_id field required"}}}]})
          end
        end
      end
      context 'with invalid image url' do
        it 'should not recognize an image' do
          VCR.use_cassette('recognize_with_invalid_image_url') do
            response = @client.recognize(:url => 'https://some.image.url/123abc.jpg', :gallery_name => 'randomgallery')
            response.should eq({"images"=>[{"status"=>"failure", "message"=>"no face(s) found in image"}]})
          end
        end
      end
      context 'with only url and gallery_name parameters with unrecognizable image' do
        before(:each) do
          VCR.use_cassette('recognize_with_unrecognizable_image') do
            #@response = @client.recognize(:url => 'http://upload.wikimedia.org/wikipedia/commons/f/f9/Obama_portrait_crop.jpg', :gallery_name => 'randomgallery')
          end
        end
        describe 'response' do
          it 'should not recognizes an image' do
            pending #Response is correct, but Faraday is returning a parsing error
            @response.first[1][0]['transaction']['status'].should eq('failure')
            @response.first[1][0]['transaction']['message'].should eq('No match found')
          end
        end
      end
      context 'with only url and gallery_name parameters' do
        before(:each) do
          VCR.use_cassette('recognize_with_url_and_gallery_name') do
            @response = @client.recognize(:url => 'https://some.image.url/123abc.jpg', :gallery_name => 'randomgallery')
          end
        end
        describe 'response' do
          it 'successfully recognizes an image' do
            @response.first[1][0]['transaction']['status'].should eq('success')
          end
        end
      end
      context 'with required parameters' do
        before(:each) do
          VCR.use_cassette('recognize') do
            @response = @client.recognize(:url => 'https://some.image.url/123abc.jpg', :gallery_name => 'randomgallery', :threshold => '.2', :max_num_results => '5')
          end
        end
        describe 'response' do
          it 'contains an images array element' do
            @response.first[0].should eq('images')
          end
          it 'contains 3 hash keys' do
            @response.first[1][0].keys.should include('time','transaction','candidates')
          end
          it 'contains how long it took to complete the task' do
            @response.first[1][0]['time'].should eq(2.02489)
          end
          it 'contains the status' do
            @response.first[1][0]['transaction']['status'].should eq('success')
          end
          it 'contains the api assigned face_id' do
            @response.first[1][0]['transaction']['face_id'].should eq('cc9424ff049026675b9f1ecccec2c076')
          end
          it 'contains the subject_id you assigned' do
            @response.first[1][0]['transaction']['subject'].should eq('image123abc')
          end
          it 'contains the gallery_name you assigned' do
            @response.first[1][0]['transaction']['gallery_name'].should eq('randomgallery')
          end
          it 'contains possible other candidates' do
            @response.first[1][0]['candidates'].size.should eq(5)
            @response.first[1][0]['candidates'].class.should eq(Array)
            @response.first[1][0]['candidates'].should eq([{"image456abc"=>"1"}, {"image789abc"=>"2"}, {"image012abc"=>"3"}, {"image345abc"=>"4"}, {"image678abc"=>"5"}])
          end
        end
      end
    end
  end

end