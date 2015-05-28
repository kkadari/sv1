Given /^I have enhanced my profile$/ do
  @prefix = Faker::Name.prefix
  visit LoginPage do |creds|
    creds.populate_page_with :username => @test_config_set[:user_1_name], :password => @test_config_set[:user_1_password]
    creds.submit
  end

  visit(UserOneProfileEditPage)
  on UserOneProfileEditPage do |edit|
    edit.title = @prefix
    edit.save
  end

end

Then /^participants that follow me can view the profile enhancements$/ do
  visit(LogoutPage)
  visit LoginPage do |creds|
    creds.populate_page_with :username => @test_config_set[:user_2_name], :password => @test_config_set[:user_2_password]
    creds.submit
  end

  visit(PeoplePage)
  on(PeoplePage).user1_profile_link
  on(UserOneProfilePage).view_more_details.click

  fail('Could not find profile enhancement') unless @browser.html.to_s.include? @prefix
end

Given /^I have restricted parts of my profile$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => @test_config_set[:user_1_name], :password => @test_config_set[:user_1_password]
    creds.submit
  end

  visit UserOnePrivacyEditPage do |edit|
    edit.security_level = 'Connections'
    edit.save
  end
  visit(LogoutPage)
end

Then /^followers can see restrictions$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => @test_config_set[:user_2_name], :password => @test_config_set[:user_2_password]
    creds.submit
  end
  on(PeoplePage).user1_profile_link
  fail 'Name not visible, and should be' unless @browser.html.include? @test_config_set[:user_1_name]
  visit(LogoutPage)
end

And /^non followers cannot see restrictions$/ do
  visit LoginPage do |creds|
    creds.populate_page_with :username => @test_config_set[:user_2_name], :password => @test_config_set[:user_2_password]
    creds.submit
  end
  on(PeoplePage).user1_profile_link
  fail 'Name visible, and should not be' if @browser.html.to_s.include? @test_config_set[:user_1_name]
end
