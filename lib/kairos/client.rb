require 'multi_json'
require 'hashie'
require 'json'

module Kairos
  class Client
    # Define the same set of accessors as the Kairos module
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options={})
      # Merge the config values from the module and those passed
      # to the client.
      merged_options = Kairos.options.merge(options)

      # Copy the merged values to this client and ignore those
      # not part of our configuration
      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    # Enroll an Image
    #
    # Example Usage:
    #  - require 'kairos'
    #  - client = Kairos::Client.new(:app_id => '1234', :app_key => 'abcde1234')
    #  - client.enroll(:url => 'https://some.url.com/to_some.jpg', :subject_id => 'gemtest', :gallery_name => 'testgallery')
    def enroll(options={})
      connection = api_set_connection(Kairos::Configuration::ENROLL)
      response   = api_post(connection, options)
      response.body
    end

    private

    def api_set_connection(endpoint)
      Faraday.new(:url => endpoint) do |builder|
        builder.response :logger
        builder.use Faraday::Adapter::NetHttp
        builder.use FaradayMiddleware::ParseJson
      end
    end

    def api_post(connection, options)
      connection.post do |request|
        request.headers['Content-Type'] = 'application/x-www-form-urlencoded'
        request.headers['app_id']       = @app_id
        request.headers['app_key']      = @app_key
        request.body                    = options.to_json
      end
    end
  end
end