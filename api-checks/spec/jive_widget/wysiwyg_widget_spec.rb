require 'spec_helper'

describe 'WYSIWYG editor' do

  it 'should return a 200 when the content picker for links is requested' do
    RestClient.get(ENV['base_url'] + '/content-picker!input.jspa?name=&instantiatedFromGUIEditor=true',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when the image picker for embeds is requested' do
    RestClient.get(ENV['base_url'] + '/rte-image-modal.jspa',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when the spell checker is sent a payload to verify' do
    payload = '{"id":"c0","method":"checkWords","params":["en_us",["test","content"]]}'

    RestClient.post(ENV['base_url'] + '/spellcheck.jspa',payload,{:cookie => @authorisation,:content_type => 'application/json'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when uploading an image to embed in the content' do
    upload_file = File.new(File.dirname(__FILE__) + '/../../bin/test.jpg')
    payload = {
        :dummyValue => 'dummy',
        'jive.token.name' => 'rte.image.token',
        :objectId => '-1',
        :objectType => '2',
        :imageFile => upload_file,
        :multipart  => true
    }

    RestClient.post(ENV['base_url'] + '/__services/v2/rest/rteImages',payload,{:cookie => @authorisation,:content_type => 'multipart/form-data'}){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when creating a new instance of the editor to reply to content' do
    path = '/__services/v2/rest/rteImages/settings?objectId=-1&objectType=-1&containerId=' + @space_id + '&containerType=14'

    RestClient.get(ENV['base_url'] + path,:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end

  it 'should return a 200 when calling the AutoTitle endpoint' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/rteLinks?href=http%3A%2F%2Fgoogle.com',:cookie => @authorisation){|response|
      assert_code_and_body(response, 200)
    }
  end
end
