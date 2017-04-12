class ShortenedUrl < ApplicationRecord
  include SecureRandom

  validates :long_url, presence: true, uniqueness: true
  validates :short_url, presence: true, uniqueness: true
  validates :submitter_id, presence: true

  def self.random_code
    code = SecureRandom.urlsafe_base64(5)
    while self.exists?(short_url: code)
      code = SecureRandom.urlsafe_base64(5)
    end
    code
  end

  def self.shortenify(user, long_url)
    self.create!(
      long_url: long_url,
      submitter_id: user.id,
      short_url: "tiny.io/#{self.random_code}"
    )
  end

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :submitter_id,
    class_name: :User
end
