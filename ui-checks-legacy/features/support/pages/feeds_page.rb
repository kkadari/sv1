class FeedsPage
  include PageObject
  extend UrlFactory

  page_url(feedspage)
  div(:incident_report,:class => 'j-act-entry')
  elements(:activity, :div, :class => 'j-act-entry ')
  link(:connections_stream, :text => 'Connections Stream')
  h1(:header,:css => '#js-activity-heading')
end
