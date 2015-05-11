require 'rspec'
require 'page-object'
require 'data_magic'
require 'fig_newton'
require 'require_all'
require 'faker'
require 'active_support/time'
require 'pdf-reader'
require 'open-uri'
require 'net/http'
require 'json'
require File.dirname(__FILE__) + '/test_config'
require File.dirname(__FILE__) + '/url_factory.rb'
require_all File.dirname(__FILE__) + '/pages'
require_all File.dirname(__FILE__) + '/api'

World(PageObject::PageFactory)
World do
  TestConfig.new
end