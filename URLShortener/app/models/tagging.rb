class Tagging < ApplicationRecord
  validates :tag_id, :link_id, presence: true 
end
