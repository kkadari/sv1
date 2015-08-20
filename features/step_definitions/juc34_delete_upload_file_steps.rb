When /^I opt to delete the uploaded document$/ do
  DeleteContent.delete_document(@doc_id, $authorisation)
end

Then /^the document is confirmed as deleted$/ do
  Content.get_document(@doc_id, $authorisation, 404)
end

Then /^can no longer be searched for$/ do
  response = Search.get_content_only_search(@doc_id, $authorisation)

  fail('Document ' + @doc_id + ' found in search') if JSON.parse(response.split(';',0)[1])['list'].length > 0
end