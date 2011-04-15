# encoding: utf-8

Sham.define do
  title { Faker::Lorem.sentence(word_count = 10) }
  author { Faker::Name.name }
  summary { Faker::Lorem.sentences(sentence_count = 5).join(' ') }
  content { Faker::Lorem.sentences(sentence_count = 20).join(' ') }
  guid(:unique => true) { (1..10).map {('a'..'z').to_a.sample}.join }

  accented_word(:unique => false) { 'ÁáÄäÉéÍíÓóÔôÚúÝýČčĎďĹĺĽľŇňŔŕŠšŤťŽžǱǳǄǆÁáÉéÍíÓóÖöŐőÚúÜüŰűŘřĚěŮů' }
  unaccented_word(:unique => false) { 'AaAaEeIiOoOoUuYyCcDdLlLlNnRrSsTtZzDzdzDzdzAaEeIiOoOoOoUuUuUuRrEeUu' }
  corrupt_xml_chars(:unique => false) { "\x00\x08\x0B\x0C\x0E\x1F" }
end

Article.blueprint do
  title
  author
  summary
  body { Sham.content }
  url
  published_at { Sham.time_in_past }
  guid
end

Article.blueprint(:accent_in_title) do
  title { Sham.title + ' ' + Sham.accented_word + ' ' +  Sham.title }
end

Article.blueprint(:accent_in_summary) do
  summary { Sham.summary + ' ' + Sham.accented_word + ' ' + Sham.summary }
end

Article.blueprint(:accent_in_body) do
  body { Sham.content + ' ' + Sham.accented_word + ' ' + Sham.content }
end

Article.blueprint(:with_corrupt_xml_chars) do
  title { Sham.corrupt_xml_chars + Sham.title }
  summary { Sham.corrupt_xml_chars + Sham.summary }
  body { Sham.corrupt_xml_chars + Sham.content }
  url { Sham.corrupt_xml_chars + Sham.url }
end

