require_relative "cli_adopt_pet/version"
require 'pry'
require 'httparty'
require 'dotenv/load'
require 'json'
require_relative './cli_adopt_pet/cli'
require_relative './cli_adopt_pet/api'


module CliAdoptPet
  class Error < StandardError; end
  # Your code goes here...
end
