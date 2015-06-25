require 'spec_helper'

describe 'The view profile page' do

  it 'should return a 200 when the profile page is requested' do
    RestClient.get(ENV['base_url'] + '/people/' + ENV['username'],:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when the activity stream for a user is requested' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/activity-stream/profile/2012',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the users connections and its count' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/2012/related/common',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/users/2012/related/common/count',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when requesting the .vcf card for a profile' do
    RestClient.get(ENV['base_url'] + '/people/' + ENV['username'] + '.vcf',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end