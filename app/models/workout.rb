class Workout < ActiveRecord::Base
  attr_accessible :workoutdate, :intervals_attributes
  has_many :intervals, :dependent => :destroy
  accepts_nested_attributes_for :intervals, :reject_if => lambda { |a| a[:interval_name].blank? }, :allow_destroy => true
end
