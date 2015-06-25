require 'spec_helper'

describe 'Actions page' do

  it 'should return a 200 when requesting the actions view' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/initializeView?tabID=',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

  it 'should return a 200 when toggling the actions view between active and resolved' do
    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list/marked?type=resolved&maxModificationDate=0&numItems=6',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }

    RestClient.get(ENV['base_url'] + '/__services/v2/rest/action-queue/list/marked?type=active&maxModificationDate=0&numItems=6',:cookie => @authorisation){|response|
      fail('Failed with ' + response.code.to_s) if response.code != 200
    }
  end

end