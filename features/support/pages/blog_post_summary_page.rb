require_relative '../modules/shared_summary_items'

class BlogPostSummaryPage
  include PageObject
  include SharedSummaryItems
  extend UrlFactory

  page_url(blogpostsummarypage)

  h1(:title, :css => '.jive-blog-post-subject-header h1')

  div(:delete_container, :class => 'jive-modal-content')
  button(:confirm_delete, :id => 'blogpost-delete-submit-button')

end
