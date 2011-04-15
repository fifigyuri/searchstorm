
content_mapping do
  url_pattern /^http:\/\/www\.pretty\.url/
  content_at '//div[@id="failing_content"]'
  content_at '//div[@id="itext_content"]'
end

content_mapping do
  url_pattern /^http:\/\/www\.skipped\.url/
end

sanitize_tags { {:elements => ['p','br', 'b', 'em', 'i', 'strong', 'u', 'a', 'h1', 'h2', 'h3', 'li', 'ol', 'ul'],
  :attributes => { 'a' => ['href'] }} }
