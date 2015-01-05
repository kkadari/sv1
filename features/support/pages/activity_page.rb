require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'

class ActivityPage
  include PageObject
  include FigNewton
  include NavRibbon
  include UserModal

  page_url("#{FigNewton.base_url}/activity")

  def confirm_first_ir_is_anonymous
    sleep 2
    incident_report = browser.divs(:class => 'j-act-entry').first
    !fail 'Not marked with anonymous avatar' unless incident_report.html.to_s.include? 'anonymous-avatar'
    !fail 'Not marked as anonymous' unless incident_report.text.include? 'Anonymous'
    !fail 'Username visible' if incident_report.text.include? FigNewton.user2_uname
  end

end