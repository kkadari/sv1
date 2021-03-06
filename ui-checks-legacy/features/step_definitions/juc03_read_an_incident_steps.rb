Then /^I can not directly access the incident report if I am not in that group$/ do
  Content.get_ir(@incident_id, $authorisation, 404)
end

Then /^I can view the anonymous incident report$/ do
  response = Content.get_ir(@incident_id, $authorisation)

  title = Nokogiri::HTML.parse(response).css('.jive-content > header > h1').text

  fail 'Content not visible or created' unless title.include? @subject
end

Then /^I as an admin can view the anonymous incident report$/ do
  response = Content.get_ir(@incident_id, $authorisation)

  title = Nokogiri::HTML.parse(response).css('.anonymous-badge').to_s

  fail 'Content not visible or created' unless title.include? 'This content was posted anonymously by its author'
end

Then /^I can search for the incident report by ID and view the incident report$/ do
  5.times do |i|
    begin
      search_response = Search.get_content_only_search(@incident_id, $authorisation)

      fail('Incident report not found in search results') unless search_response.include? @incident_id

      Content.get_ir(@incident_id, $authorisation)
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

Then /^I can not find the incident report in search if I am not in that group$/ do
  Content.get_ir(@incident_id, $authorisation, 404)
end

Then /^I will be able to view my recently created report$/ do
  response = Content.get_ir(@incident_id, $authorisation)

  tlp = Nokogiri::HTML.parse(response).css('.ihmbar').text

  fail 'Content not visible or created' unless tlp.downcase.include? @marking
end

###### SMOKE TEST STEPS

Then /^I can view the incident report$/ do
  on(IncidentReportSummaryPage).wait_until do
    on(IncidentReportSummaryPage).title?
    on(IncidentReportSummaryPage).comment?
  end

  fail 'Title not visible' unless on(IncidentReportSummaryPage).title?
  fail 'IHM not visible' unless on(IncidentReportSummaryPage).ihm_bar?
  fail 'Body not visible' unless on(IncidentReportSummaryPage).original_message?
  fail 'Comment not visible' unless on(IncidentReportSummaryPage).comment?
end
