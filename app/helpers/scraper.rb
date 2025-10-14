# frozen_string_literal: true
require "httparty"
require "nokogiri"

class Scraper
  def self.search(url)
    response = HTTParty.get(url)

    document = Nokogiri::HTML(response.body)
    github_followers_number = 0
    github_following_number = 0
    document.css(".Link--secondary.no-underline.no-wrap").each do |a|
      if a.attribute("href").to_s.include? 'tab=followers'
        github_followers_number = a.text.delete("^0-9")
      end

      if a.attribute("href").to_s.include? 'tab=following'
        github_following_number = a.text.delete("^0-9")
      end

    end

    github_username = document.css(".p-nickname").first.text.strip
    github_profile_image_url = document.css("img").first.attribute("src").value

    puts document.css(".js-yearly-contributions").first

    document.css("div.js-yearly-contributions").each do |a|
      puts 'a'
      if a.text.to_s.include? "last year"
        puts a.text
      end

    end
    github_last_year_contributions_number = 1

    {
      github_username: github_username,
      github_followers_number: github_followers_number,
      github_following_number: github_following_number,
      github_starts_number: 1,
      github_last_year_contributions_number: 1,
      github_profile_image_url: github_profile_image_url,
      github_organization: 'github_username',
      github_location: 'github_username'
    }
  end

end
