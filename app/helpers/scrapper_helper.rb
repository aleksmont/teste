# frozen_string_literal: true
require "httparty"
require "nokogiri"

module ScrapperHelper

  def get_content(url)
    response = HTTParty.get(url)
    Nokogiri::HTML(response.body)
  end

  def check_url(url)
    # TODO improve this check with more relevant search
    begin
      document = get_content(url)
      github_username = document.css(".p-nickname").first
      return false if github_username.nil?
      github_username.text.strip.length > 1
    rescue StandardError => e
      puts e.message
      false
    end
  end

  def search(url)
    begin
      url = url + '?tab=stars'
      document = get_content(url)

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

      github_starts_number = 0
      document.css("a").css(".UnderlineNav-item").each do |a|
        if a.attribute("href").to_s.include? 'tab=stars'
          github_starts_number = a.css("span").text.to_s.strip.delete("^0-9")
        end
      end

      github_organization = ''
      github_location = ''
      document.css(".vcard-detail.pt-1.hide-sm.hide-md").each do |a|
        if a.attribute("itemprop").to_s.include? 'homeLocation'
          github_location = a.text.to_s.strip
        end
        if a.attribute("itemprop").to_s.include? 'worksFor'
          github_organization = a.text.to_s.strip
        end
      end


      github_last_year_contributions_number = 0
      puts 'github_last_year_contributions_number'
      puts 'github_last_year_contributions_number'
      puts 'github_last_year_contributions_number'

      puts document.css('#js-contribution-activity-description')

      # document.css(".vcard-detail.pt-1.hide-sm.hide-md").each do |a|
      #   # if a.text.to_s.include? 'contributions'
      #   puts a.text
      #   # end
      #
      #   # if a.attribute("href").to_s.include? 'tab=stars'
      #   #   github_starts_number = a.css("span").text.to_s.strip.delete("^0-9")
      #   # end
      # end

      # document.css(".d-flex").each do |a|
      #   # puts a.text
      #   if a.text.to_s.include? "last year"
      #     puts a.text
      #   end
      #
      # end


      {
        success: true,
        data: {
          github_username: github_username,
          github_followers_number: github_followers_number,
          github_following_number: github_following_number,
          github_starts_number: github_starts_number,
          github_last_year_contributions_number: github_last_year_contributions_number,
          github_profile_image_url: github_profile_image_url,
          github_organization: github_organization,
          github_location: github_location
        }
      }
    rescue StandardError => e
      puts e
      {
        success: false,
        data: nil
      }
    end
  end

end
