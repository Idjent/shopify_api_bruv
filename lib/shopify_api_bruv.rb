# frozen_string_literal: true

require 'dotenv/load'
require 'httparty'

Dir.glob(
  File.join(File.dirname(__FILE__), '**', '*.rb')
).each do |file|
  next if file == __FILE__

  require(file)
end
