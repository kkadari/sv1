When /^I navigate to the list view of people page$/ do
  People.post_set_grid_view(@browser.cookies.to_a)

  @response = People.get_browse_people(@browser.cookies.to_a)
end

Then /^I will see the last logged in date for each person$/ do
  fail('Last logged in date not found') unless Nokogiri::HTML.parse(@response).css('.j-td-lastloggedin')[0].text.include? 'EDT 2015'
end

Then /^I can sort by last logged in date$/ do
  response = People.get_order_by_date(@browser.cookies.to_a)

  logged_in_dates = Nokogiri::HTML.parse(response).css('.j-td-lastloggedin')

  date_1 = Time.parse logged_in_dates[0].text
  date_2 = Time.parse logged_in_dates[1].text

  fail('Order by most recent date failed') unless date_1 > date_2
end