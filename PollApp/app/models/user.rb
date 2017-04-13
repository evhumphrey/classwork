class User < ApplicationRecord
  validates :user_name, uniqueness: true, presence: true

  has_many :authored_polls,
  primary_key: :id,
  foreign_key: :author,
  class_name: "Poll"

  has_many :responses,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: "Response"
end
