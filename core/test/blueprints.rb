require 'machinist/active_record'
require 'machinist/object'
require 'ffaker'
require 'sham'

class ActiveSupport::TestCase
  setup { Sham.reset }
end

def random_date_in_past(params={})
  years_back = params[:year_range] || 5
  year = (rand * (years_back)).ceil + (Time.now.year - years_back)
  month = (rand * 12).ceil
  day = (rand * 31).ceil
  series = [date = Time.local(year, month, day)]
  if params[:series]
    params[:series].each do |some_time_after|
      series << series.last + (rand * some_time_after).ceil
    end
    return series
  end
  date
end

Sham.define do
  url { 'http://' + Faker::Internet.domain_name }
  incorrect_url { Faker::Internet.domain_name }
  time_in_past { random_date_in_past(:year_range => 3) }
end

blueprints_dir = "#{File.dirname(__FILE__)}/blueprints"
Dir.entries(blueprints_dir).select \
  { |filename| filename =~ /.*\.rb/ }.each do |blueprint_file|
    require "#{blueprints_dir}/#{blueprint_file}"
  end

