require 'spec_helper'

describe 'definition of scrapping rule' do

  subject { Searchstorm::Gather }

  it 'can define an execution block for a url pattern' do
    subject.on_pages_like(%r{http://www.foo.com/[a-z]+}) do |page|
      page.should not_be_nil
    end
  end
end
