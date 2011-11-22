require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Workout.new.valid?
  end
end
