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
            response.should eq({"Errors"=>[{"ErrCode"=>1002, "Message"=>"gallery_name one or more required parameters are missing"}]})
          end
        end
      end
      context 'with invalid image url' do
        it 'should not recognize an image' do
          VCR.use_cassette('recognize_with_invalid_image_url') do
            response = @client.recognize(:url => 'https://some.image.url/123abc.jpg', :gallery_name => 'randomgallery')
            response.should eq({"Errors"=>[{"ErrCode"=>5001, "Message"=>"invalid url was sent"}]})
          end
        end
      end
      context 'with only url and gallery_name parameters with unrecognizable image' do
        before(:each) do
          VCR.use_cassette('recognize_enroll_image_first') do
            @response = @client.enroll(:url => 'http://www.imperialteutonicorder.com/sitebuildercontent/sitebuilderpictures/jesus4.jpg', :subject_id => 'image123abc', :gallery_name => 'randomgallery')
          end

          VCR.use_cassette('recognize_with_unrecognizable_image') do
            @response = @client.recognize(:url => 'http://upload.wikimedia.org/wikipedia/commons/f/f9/Obama_portrait_crop.jpg', :gallery_name => 'randomgallery')
          end
        end

        describe 'response' do
          it 'should not recognize an image' do
            @response.should eq({"images" => [{"transaction"=>{"status"=>"failure", "topLeftX"=>433, "topLeftY"=>536, "gallery_name"=>"randomgallery", "height"=>722, "width"=>722, "face_id"=>1, "quality"=>0.91429, "message"=>"No match found"}}]})
          end
        end
      end
      context 'with only url and gallery_name parameters' do
        before(:each) do
          VCR.use_cassette('recognize_with_url_and_gallery_name') do
            @response = @client.recognize(:url => 'http://www.imperialteutonicorder.com/sitebuildercontent/sitebuilderpictures/jesus4.jpg', :gallery_name => 'randomgallery')
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
            @response = @client.recognize(:url => 'http://www.imperialteutonicorder.com/sitebuildercontent/sitebuilderpictures/jesus4.jpg', :gallery_name => 'randomgallery', :threshold => '.2', :max_num_results => '5')
          end
        end
        describe 'response' do
          it 'contains an images array element' do
            @response.first[0].should eq('images')
          end
          it 'contains 3 hash keys' do
            @response.first[1][0].keys.should include('transaction','candidates')
          end
          it 'contains the status' do
            @response.first[1][0]['transaction']['status'].should eq('success')
          end
          it 'contains the gallery_name you assigned' do
            @response.first[1][0]['transaction']['gallery_name'].should eq('randomgallery')
          end
        end
      end
    end
  end

end