require 'stew'
require 'webmock/rspec'
require 'vcr'
require 'simplecov'
require 'simplecov-rcov'

SimpleCov.formatter = SimpleCov::Formatter::RcovFormatter

SimpleCov.start


if File.exists?("spec/config.yml") == false
  puts "Error. Please make sure that 'spec/config.yml' exists with the correct values before running the specs. See example file"
  exit
end

config = YAML::load_file("spec/config.yml")
STEAM_API_KEY = config['steam_api_key']

Stew::configure({steam_api_key: STEAM_API_KEY})


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'
  config.fail_fast = true
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/cassette_library'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.default_cassette_options = {:re_record_interval => 3600*24, :record => :new_episodes}
end