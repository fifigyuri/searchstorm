
Factory.define(:article) do |f|
  f.title { Faker::Lorem.sentence }
  f.body { Faker::Lorem.paragraphs.join("\n\n") }
  f.author { Faker::Name.name }
  f.summary { Faker::Lorem.sentences(sentence_count = 5).join(' ') }
  f.url { Faker::Internet.http_url }
end

