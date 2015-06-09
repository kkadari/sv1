require 'spec_helper'

describe 'People page' do

  it 'should return a 200 when requested' do
    RestClient.get(ENV['base_url'] + '/people',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end