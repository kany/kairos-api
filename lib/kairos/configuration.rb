module Kairos

  module Configuration
    VALID_CONNECTION_KEYS  = [:app_id, :app_key].freeze
    VALID_OPTIONS_KEYS     = [:url, :subject_id, :gallery_name, :threshold, :max_num_results, :selector].freeze
    VALID_CONFIG_KEYS      = VALID_CONNECTION_KEYS + VALID_OPTIONS_KEYS

    DEFAULT_USER_AGENT     = "Kairos API Ruby Gem #{Kairos::VERSION}".freeze
    DEFAULT_APP_ID         = nil
    DEFAULT_APP_KEY        = nil

    ENROLL                 = 'http://api.kairos.com/enroll'
    RECOGNIZE              = 'http://api.kairos.com/recognize'
    DETECT                 = 'http://api.kairos.com/detect'
    GALLERY_LIST_ALL       = 'http://api.kairos.com/gallery/list_all'
    GALLERY_VIEW           = 'http://api.kairos.com/gallery/view'
    GALLERY_REMOVE_SUBJECT = 'http://api.kairos.com/gallery/remove_subject'

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
