module Kairos

  module Configuration
    VALID_CONNECTION_KEYS = [:app_id, :api_key].freeze
    VALID_OPTIONS_KEYS    = [:url, :subject_id, :gallery_name, :threshold, :max_num_results, :selector].freeze
    VALID_CONFIG_KEYS     = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_USER_AGENT    = "Kairos API Ruby Gem #{Kairos::VERSION}".freeze

    DEFAULT_APP_ID          = nil
    DEFAULT_API_KEY         = nil
    DEFAULT_URL             = nil
    DEFAULT_SUBJECT_ID      = nil
    DEFAULT_GALLERY_NAME    = nil
    DEFAULT_THRESHOLD       = '.2'
    DEFAULT_MAX_NUM_RESULTS = '5'
    DEFAULT_SELECTOR        = 'FULL'

    DEFAULT_ENDPOINT_TO_ENROLL         = 'http://api.kairos.io/enroll'
    DEFAULT_ENDPOINT_TO_RECOGNIZE      = 'http://api.kairos.io/recognize'
    DEFAULT_ENDPOINT_TO_DETECT         = 'http://api.kairos.io/detect'
    DEFAULT_ENDPOINT_TO_LIST_ALL       = 'http://api.kairos.io/gallery/list_all'
    DEFAULT_ENDPOINT_TO_VIEW           = 'http://api.kairos.io/gallery/view'
    DEFAULT_ENDPOINT_TO_REMOVE_SUBJECT = 'http://api.kairos.io/gallery/remove_subject'

    # Build accessor methods for every config options so we can do this, for example:
    #   Kairos.format = :xml
    attr_accessor *VALID_CONFIG_KEYS

    # Make sure we have the default values set when we get 'extended'
    def self.extended(base)
      base.reset
    end

    def reset
      self.app_id          = DEFAULT_APP_ID
      self.api_key         = DEFAULT_API_KEY
      self.url             = DEFAULT_URL
      self.subject_id      = DEFAULT_SUBJECT_ID
      self.gallery_name    = DEFAULT_GALLERY_NAME
      self.threshold       = DEFAULT_THRESHOLD
      self.max_num_results = DEFAULT_MAX_NUM_RESULTS
      self.selector        = DEFAULT_SELECTOR
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