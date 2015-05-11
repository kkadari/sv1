require_relative '../modules/nav_ribbon'
require_relative '../modules/user_modal'
require_relative '../modules/ihm_bar'
require_relative '../modules/publish_bar'

class BlogPostPage
  include PageObject
  include NavRibbon
  include UserModal
  include DataMagic
  include IhmBar
  include PublishBar
  extend UrlFactory

  page_url(blogpostpage)

  text_field(:subject, :name => 'subject')
  text_area(:body, :class => 'usertext')
  text_field(:tags, :xpath => "//div[contains(@id,'jive-compose-tags-form')]//input[@type=\"text\"][1]")
  button(:save, :id => 'submitButton')

  def complete_blog_post(data = {})
    @browser.link(:id => 'wysiwygtext_html').when_present.click
    populate_page_with data_for(:BlogPostPage, data)
    @browser.button(:text => 'Create blog post').when_present.click

  end
end
