require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Workout.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Workout.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Workout.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to workout_url(assigns(:workout))
  end

  def test_edit
    get :edit, :id => Workout.first
    assert_template 'edit'
  end

  def test_update_invalid
    Workout.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Workout.first
    assert_template 'edit'
  end

  def test_update_valid
    Workout.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Workout.first
    assert_redirected_to workout_url(assigns(:workout))
  end

  def test_destroy
    workout = Workout.first
    delete :destroy, :id => workout
    assert_redirected_to workouts_url
    assert !Workout.exists?(workout.id)
  end
end
