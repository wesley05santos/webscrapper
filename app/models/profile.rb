class Profile < ApplicationRecord
  validates :name, :url, presence: true
  before_save :normalize_url

  scope(:search, lambda do |query|
    where("name ILIKE ?", "%#{query}%").or(
    where("url ILIKE ?", "%#{query}%"))
  end)

  private

  def normalize_url
    self.url = "https://github.com/#{self.url}"
  end
end
