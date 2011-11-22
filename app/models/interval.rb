class Interval < ActiveRecord::Base
  attr_accessible :interval_name, :workout_id
  belongs_to :workout
end
