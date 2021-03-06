Given /^"([^"]*)" has updated their profile$/ do |user|
  switch_user(user)
  user_profile = TestConfig.return_profile(user)

  # Before we post we grab the token from the edit profile page for our payload otherwise the post will fail
  response = Profile.get_edit_profile(user_profile[:user_id], $authorisation)
  @token = Nokogiri::HTML(response).css('input[name*="edit.profile."]')[0]['value']

  payload = ProfilePayload.new(
      Faker::Name.prefix,
      Faker::PhoneNumber.phone_number,
      Faker::PhoneNumber.phone_number,
      Faker::Internet.email,
      Faker::Lorem.sentence,
      user_profile[:username],
      user_profile[:user_id],
      @token
  ).payload

  Profile.post_edit_profile(payload, $authorisation)
end

When(/^I navigate to the feeds page as "([^"]*)"$/) do |user|
  switch_user(user)

  @response = Feeds.get_activity($authorisation)
end

Then /^I am informed that "([^"]*)" has updated their profile$/ do |user|
  5.times do |i|
    begin
      user_profile = TestConfig.return_profile(user)

      html_doc = Nokogiri::HTML(@response)

      fail('User updated feed item missing') unless html_doc.css('.j-act-g-item').text.strip.include?(user_profile[:username] + ' updated profile information')
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Given /^I have navigated to the edit profile privacy page as "([^"]*)"$/ do |user|
  switch_user(user)

  @user_profile = TestConfig.return_profile(user)
  response = Profile.get_edit_privacy_profile(@user_profile[:user_id], $authorisation)

  # Extract profile fields and current values (for building a payload)
  @fields = Hash.new()
  Nokogiri::HTML(response).xpath('//select[starts-with(@name, "profile[")]').each do |items|
    field_name = items.attributes['name'].value
    s = '#' + items.attributes['id'].value + ' option[@selected="selected"]'
    selected_value =  Nokogiri::HTML(response).css(s).attr('value').to_s
    @fields[field_name] = selected_value
  end

  @token = Nokogiri::HTML(response).css('input[name*="edit.profile.security"]')[0]['value']
end

When /^I make changes to my privacy details and save them$/ do
  @name_level = '100' + (2 * rand(3) + 1).to_s

  payload = ProfilePrivacyPayload.new(@name_level, @user_profile[:username], @user_profile[:user_id], @token, @fields).payload

  Profile.post_edit_privacy_profile(payload, $authorisation)
end

Then /^my privacy profile details are updated$/ do
  5.times do |i|
    begin
      response = Profile.get_edit_privacy_profile(@user_profile[:user_id], $authorisation)

      id =  Nokogiri::HTML(response).css('select[id="nameSecurityLevelID"] > option[selected="selected"]')[0]['value']

      fail('Security level for name didn\'t update') unless id.include? @name_level
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end

Given /^I have navigated to the edit profile page as "([^"]*)"$/ do |user|
  switch_user(user)

  @user_profile = TestConfig.return_profile(user)

  # Before we post we grab the token from the edit profile page for our payload otherwise the post will fail
  response = Profile.get_edit_profile(@user_profile[:user_id], $authorisation)
  @token = Nokogiri::HTML(response).css('input[name*="edit.profile."]')[0]['value']
end

When /^I make changes to my profiles details and save them$/ do
  @prefix   = Faker::Name.prefix
  @phone_1  = Faker::PhoneNumber.phone_number
  @phone_2  = Faker::PhoneNumber.phone_number
  @email    = Faker::Internet.email
  @sentence = Faker::Lorem.sentence

  payload = ProfilePayload.new(
      @prefix,
      @phone_1,
      @phone_2,
      @email,
      @sentence,
      @user_profile[:username],
      @user_profile[:user_id],
      @token
  ).payload

  Profile.post_edit_profile(payload, $authorisation)
end

Then /^my profile details are updated$/ do
  5.times do |i|
    begin
      response = Profile.get_edit_profile(@user_profile[:user_id], $authorisation)

      html_doc = Nokogiri::HTML(response)
      fail('Prefix not updated') unless html_doc.css('input[name="profile[5006].value"]').to_s.include?(@prefix)
      fail('Phone 1 not updated') unless html_doc.css('input[name="profile[5009].phoneNumbers[0].phoneNumber"]').to_s.include?(@phone_1)
      fail('Phone 2 not updated') unless html_doc.css('input[name="profile[5008].phoneNumbers[0].phoneNumber"]').to_s.include?(@phone_2)
      fail('Email not updated') unless html_doc.css('input[name="profile[5007].emails[0].email"]').to_s.include?(@email)
      fail('Sentence not updated') unless html_doc.css('textarea[name="profile[5002].value"]').to_s.include?(@sentence)
      break
    rescue => e
      if i < 5
        sleep(1)
      else
        fail(e)
      end
    end
  end
end
