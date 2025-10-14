# frozen_string_literal: true
require "httparty"
require "nokogiri"

class Scraper
  def self.search(query)
    response = HTTParty.get("https://www.scrapingcourse.com/ecommerce/")

    puts 'response'
    puts response
  end

end
