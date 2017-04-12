class Visit < ApplicationRecord
  validates :visitor_id, presence: true
  validates :link_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      visitor_id: user.id,
      link_id: shortened_url.id
    )
  end

end
