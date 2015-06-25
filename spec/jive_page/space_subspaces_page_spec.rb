require 'spec_helper'

describe 'Space subspaces' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/community/test-space/places',{:cookie => @authorisation, :content_type => 'application/json'}){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end