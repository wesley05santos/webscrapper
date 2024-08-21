require 'faraday'

class Profile < ApplicationRecord
  validates :name, :url, presence: true
  validate :verify_url_exist

  scope(:search, lambda do |query|
    where("name ILIKE ?", "%#{query}%").or(
    where("url ILIKE ?", "%#{query}%"))
  end)

  private

  def normalize_url
    return if self.url.include?('https://github.com/')

    self.url = "https://github.com/#{self.url}"
  end

  def verify_url_exist
    normalize_url
    return if ::Faraday.get(self.url).status == 200

    @errors.add(:Url, 'invalid')
  end
end

