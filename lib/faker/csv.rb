require 'faker/csv/version'
require 'faker/csv/maker'
require 'json'
require 'faker'

module Faker
  module Csv
    def self.make(file_path, output_file_path = nil)
      # Faker::Config.locale = :ja

      p "called make #{file_path}"
      json = json_parse(file_path)
      exit unless json
      Maker.new(json).make
    end

    private

    def self.json_parse(file_path)
      json = open(file_path) do |io|
        JSON.load(io)
      end
      json
    rescue Errno::ENOENT => e
      puts 'JSON file not found'
      return false
    end
  end
end
