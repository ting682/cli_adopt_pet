require_relative "cli_adopt_pet/version"
#require 'pry'
require 'httparty'
require 'dotenv/load'
require_relative './cli_adopt_pet/cli'
require_relative './cli_adopt_pet/api'
require_relative './cli_adopt_pet/pet'

module CliAdoptPet
  class Error < StandardError; end
  # Your code goes here...
end
