require "open-uri"
require "net/http"
require "dotenv"

Dotenv.load!(".env")
# Example link:
# https://adventofcode.com/2022/day/1/input

AOC_DOMAIN = "https://adventofcode.com"

def get_input_file(year, day)
  session_token = ENV["ADVENT_OF_CODE_SESSION"]

  url = "#{AOC_DOMAIN}/#{year}/day/#{day}/input"
  uri = URI.parse(url)
  response = Net::HTTP.get_response(uri, {"Cookie" => "session=#{session_token}"})

  if response.is_a?(Net::HTTPSuccess)
    day = day.rjust(2, "0")
    File.write("inputs/year_#{year}/day_#{day}.txt", response.body)
    puts "File downloaded successfully!"
  else
    puts "Failed to download the file: #{response.code} #{response.message}"
  end
end

puts "Welcome to Advent of Code!"
puts "Which year?"
year = gets.chomp
puts "Which day?"
day = gets.chomp

puts "Downloading #{year} day #{day}..."
get_input_file(year, day)
