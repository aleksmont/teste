class Profile < ApplicationRecord
  include ScrapperHelper
  #
  # Validations
  #

  validates :name, presence: true
  validates :github_url, presence: true
  # validates :github_username, presence: true, uniqueness: true
  validate :valid_github_url

  #
  # Lifecycle
  #

  before_create :short_github_url, :complete_info

  def valid_github_url
    unless check_url(self.github_url)
      errors.add(:github_url, "Github url error")
    end
  end

  def short_github_url
    self.github_short_url = RailsUrlShortener::Url.generate(self.github_url).key
  end

  def complete_info(selenium = false)

    info = search(self.github_url, selenium)

    if info[:success]
      self.github_username = info[:data][:github_username]
      self.github_followers_number = info[:data][:github_followers_number]
      self.github_following_number = info[:data][:github_following_number]
      self.github_starts_number = info[:data][:github_starts_number]
      self.github_last_year_contributions_number = info[:data][:github_last_year_contributions_number]
      self.github_profile_image_url = info[:data][:github_profile_image_url]
      self.github_organization = info[:data][:github_organization]
      self.github_location = info[:data][:github_location]
    end

  end

  def reload_info
    self.complete_info(true)
    self.save
  end

end
