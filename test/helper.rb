# I know it's bad to require rubygems, but I haven't yet figured out how to get around it
require 'rubygems'
require 'test/unit'
require 'redgreen'
require 'vcr'
require 'fakeweb'
require 'shoulda-context'
require 'boston_marathon'

VCR.config do |c|
  c.cassette_library_dir = 'test/vcr_cassettes'
  c.stub_with :fakeweb
  c.default_cassette_options = { :record => :once }
end
