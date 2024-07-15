class Profile < ApplicationRecord
  validates :name, :url, presence: true
  before_save :normalize_url

  private

  def normalize_url
    self.url = "https://github.com/#{self.url}"
  end
end
