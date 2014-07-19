# Kairos

Ruby gem for the Kairos facial recognition API - https://developer.kairos.io/

## Installation

Add this line to your application's Gemfile:

    gem 'kairos'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kairos

## Usage
https://developer.kairos.io/docs

1. Kairos::Client.enroll(:url => 'https://some.url.com/to_some.jpg', :subject_id => 'gemtest', :gallery_name => 'testgallery'):

Takes an image and stores it as a face template into a gallery you define

    $ require 'kairos'

    $ client = Kairos::Client.new(:app_id => '1234', :app_key => 'abcde1234')

    $ client.enroll(:url => 'https://some.url.com/to_some.jpg', :subject_id => 'gemtest', :gallery_name => 'testgallery')

2. Kairos::Client.recognize(:url => 'https://some.image.url/123abc.jpg', :gallery_name => 'randomgallery', :threshold => '.2', :max_num_results => '5'):
 - Takes an image and tries to match it against the already enrolled images in a gallery you define

3. Kairos::Client.detect(:url => 'https://some.url.com/to_some.jpg', :selector => 'FULL'):
 - Takes an image and returns the facial features found within it

4. Kairos::Client.gallery_list_all:
 - Lists out all the galleries you have subjects enrolled in

5. Kairos::Client.gallery_view(:gallery_name => 'testgallery'):
 - Lists out all the subjects you have enrolled in a specified gallery

6. Kairos::Client.gallery_remove_subject(:gallery_name => 'randomgallery', :subject_id => 'image123abc'):
 - Removes a subject from a specified gallery

## To Do List
1) Trim unnessary gem dependencies
2) Expand documentation
3) Expand test specs to cover more scenarios and edge cases
4) DRY up code where possible

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## References
Thank you to gregmoreno for creating this api template - https://github.com/gregmoreno/awesome