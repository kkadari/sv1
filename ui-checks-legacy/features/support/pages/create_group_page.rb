class CreateGroupPage
  include PageObject
  extend UrlFactory

  page_url(creategrouppage)

  text_field(:name, :id => 'jive-socialgroup-name-input')
  text_area(:description, :id => 'jive-socialgroup-desc')
  text_field(:tags, :id => 'jive-tags')
  link(:advanced, :text => 'Advanced options')
  radio_button(:open, :id => 'jive-socialgroup-type-OPEN')
  radio_button(:members_only, :id => 'jive-socialgroup-type-MEMBER_ONLY')
  radio_button(:private, :id => 'jive-socialgroup-type-PRIVATE')
  radio_button(:secret, :id => 'jive-socialgroup-type-SECRET')
  button(:save, :name => 'save')
  h1(:content_header, :css => '#jive-body-intro-content h1')

end
