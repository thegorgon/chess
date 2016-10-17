$LOAD_PATH << File.expand_path('../../lib')

require 'pry'
require 'chess'

# require spec helpers
Dir[File.expand_path('./spec/helpers/**/*.rb')].each { |file| require file }

RSpec.configure do |_config|
end
