require 'spec_helper'

describe 'definition of scrapping rule' do

  subject { Searchstorm::Gather }

  it 'holds a crawler instance' do
    subject.url_seed = 'seedsite.com'
    subject.crawler.should_not be_nil
    subject.crawler.should be_instance_of Anemone::Core
  end
end
