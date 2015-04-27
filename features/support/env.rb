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
require_all File.dirname(__FILE__) + '/pages'
require_all File.dirname(__FILE__) + '/api'

if ENV['HEADLESS']
  require 'headless'
  headless = Headless.new
  headless.start
  at_exit do
    headless.destroy
  end
end

World(PageObject::PageFactory)
World do
  TestConfig.new
end

PageObject::PageFactory.routes = {
  :default => [[WelcomePage, :click_home],
               [HomePage]],

  :user1_profile_route => [[HomePage, :click_people],
                           [PeoplePage, :view_profile],
                           [UserOneProfilePage, :edit_profile],
                           [UserOneProfileEditPage, :edit_privacy_settings],
                           [UserOnePrivacyEditPage]],

  :custom_group_ir_route => [[HomePage, :click_places],
                             [PlacesPage, :view_custom_group],
                             [CustomGroupPage, :view_content_page],
                             [CustomGroupContentPage, :create_incident_report],
                             [IncidentReportPage]],
}