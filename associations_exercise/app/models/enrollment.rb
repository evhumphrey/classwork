class Enrollment < ActiveRecord::Base
  belongs_to :courses,
    primary_key: :id,
    foreign_key: :course_id,
    class_name: :Course
  
end
