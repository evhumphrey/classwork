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

  has_many :visits_ids,
    primary_key: :id,
    foreign_key: :link_id,
    class_name: :Visit

  has_many :taggings,
    primary_key: :id,
    foreign_key: :link_id,
    class_name: :Tagging

  has_many :tag_topics,
    through: :taggings,
    source: :tag

  def num_clicks
    # Visit.all.select { |visit| visit.link_id == self.id }.count
    self.visits_ids.count
  end

  def num_uniques
    self.visits_ids.select(:visitor_id).distinct.count
  end

  def num_recent_uniques
    # Visit.where({ created_at: 100.minutes.ago..Time.now })
    self.visits_ids.where({
        created_at: 10.minutes.ago..Time.now
      }).select(:visitor_id).distinct.count
  end
end
