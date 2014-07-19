require 'spec_helper'

describe Kairos::Client do

  describe '#gallery_remove_subject' do
    before do
      @config = {
        :app_id          => 'abc1234',
        :app_key         => 'asdfadsfasdfasdfasdf'
      }
      @client = Kairos::Client.new(@config)
    end

    it 'responds to recognize' do
      @client.should respond_to(:gallery_remove_subject)
    end

    context 'with valid credentials' do
      context 'with missing parameters' do
        it 'should not remove subject' do
          VCR.use_cassette('gallery_remove_subject_with_missing_parameters') do
            response = @client.gallery_remove_subject(:gallery_name => 'gemtest')
            response.should eq({"Errors"=>[{"ErrorCode"=>5006, "Message"=>"the following required parameter is not included:  subject_id"}]})
          end
        end
      end
      context 'with unmatched subject_id' do
        it 'should accept any subject and try to remove it, if it exists' do
          VCR.use_cassette('gallery_remove_subject_with_unmatched_subject') do
            response = @client.gallery_remove_subject(:gallery_name => 'gemtest', :subject_id => 'abcdefghi')
            response.should eq("INVALID_JSON: {\n\t\"status\": \"complete\",\n\t\"message\": \"subject id abcdefghi has been successfully removed }")
          end
        end
      end
      context 'with required parameters' do
        before(:each) do
          VCR.use_cassette('gallery_remove_subject') do
            @response = @client.gallery_remove_subject(:gallery_name => 'randomgallery', :subject_id => 'image123abc')
          end
        end
        describe 'response' do
          it 'subject is removed from gallery' do
            @response.should eq("INVALID_JSON: {\n\t\"status\": \"complete\",\n\t\"message\": \"subject id image123abc has been successfully removed }")
          end
        end
      end
    end
  end

end