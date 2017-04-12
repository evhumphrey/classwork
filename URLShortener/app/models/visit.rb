class Visit < ApplicationRecord
  validates :visitor_id, presence: true
  validates :link_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      visitor_id: user.id,
      link_id: shortened_url.id
    )
  end

  belongs_to :visitors,
    primary_key: :id,
    foreign_key: :visitor_id,
    class_name: :User
end
