## STILL UNDER DEVELOPMENT - NOT READY FOR PRODUCTION USE

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

1. Kairos.enroll(url, subject_id, gallery_name):
 - Takes an image and stores it as a face template into a gallery you define

2. Kairos.recognize(url, gallery_name, threshold, max_num_results):
 - Takes an image and tries to match it against the already enrolled images in a gallery you define

3. Kairos.detect(url, selector):
 - Takes an image and returns the facial features found within it

4. Kairos.gallery_list_all:
 - Lists out all the galleries you have subjects enrolled in

5. Kairos.gallery_view(gallery_name):
 - Lists out all the subjects you have enrolled in a specified gallery

6. Kairos.gallery_remove_subject(gallery_name, subject_id):
 - Removes a subject from a specified gallery

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
