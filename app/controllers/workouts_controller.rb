class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all
    #@date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today 
  end

  def show
    @workout = Workout.find(params[:id])
  end

  def new
    @workout = Workout.new
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today 
    3.times do 
      @workout.intervals.build
    end
  end

  def create
    @workout = Workout.new(params[:workout])
    if @workout.save
      redirect_to @workout, :notice => "Successfully created workout."
    else
      render :action => 'new'
    end
  end

  def edit
    @workouts = Workout.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today 
  end

  def update
    @workout = Workout.find(params[:id])
    if @workout.update_attributes(params[:workout])
      redirect_to @workout, :notice  => "Successfully updated workout."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    redirect_to workouts_url, :notice => "Successfully destroyed workout."
  end
end
