module Kairos

  module Configuration
    VALID_CONNECTION_KEYS = [:app_id, :app_key].freeze
    VALID_OPTIONS_KEYS    = [:url, :subject_id, :gallery_name, :threshold, :max_num_results, :selector].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_USER_AGENT    = "Kairos API Ruby Gem #{Kairos::VERSION}".freeze
    DEFAULT_APP_ID        = nil
    DEFAULT_APP_KEY       = nil

    DEFAULT_ENDPOINT           = 'http://api.kairos.io'
    ENDPOINT_TO_ENROLL         = 'http://api.kairos.io/enroll'
    ENDPOINT_TO_RECOGNIZE      = 'http://api.kairos.io/recognize'
    ENDPOINT_TO_DETECT         = 'http://api.kairos.io/detect'
    ENDPOINT_TO_LIST_ALL       = 'http://api.kairos.io/gallery/list_all'
    ENDPOINT_TO_VIEW           = 'http://api.kairos.io/gallery/view'
    ENDPOINT_TO_REMOVE_SUBJECT = 'http://api.kairos.io/gallery/remove_subject'

    # Build accessor methods for every config options so we can do this, for example:
    #   Kairos.format = :xml
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    def reset
      self.app_id  = DEFAULT_APP_ID
      self.app_key = DEFAULT_APP_KEY
    end

    def configure
      yield self
    end

    # Return the configuration values set in this module
    def options
      Hash[ * VALID_CONFIG_KEYS.map { |key| [key, send(key)] }.flatten ]
    end
  end

end