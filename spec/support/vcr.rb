VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  #adicionou p usar :vcr
  config.configure_rspec_metadata!
end