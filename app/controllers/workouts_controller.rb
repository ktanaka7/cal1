class WorkoutsController < ApplicationController
  def index
    @workouts = Workout.all
    # @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
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
    if params[:id] == '0'
      @workout = Workout.new
      @workout.workoutdate = params[:date]
      3.times do 
        @workout.intervals.build
      end
    else
      @workout = Workout.find(params[:id])
    end
  end

  def update
    @workout = Workout.find(params[:id])
    if @workout.update_attributes(params[:workout])
      redirect_to @workout, :notice  => "Successfully updated workout."
    else
      render :action => 'edit'
    end
  end

  def edit_multiple
    case params[:cmd]
    when "add_interval"
      @workouts = Workout.where(:workoutdate => params[:date].to_time)
      if @workouts.any?
        workout =  @workouts[0]
        workout.intervals.build
        workout.save
      else
        workout = Workout.new
        workout.workoutdate = params[:date]
        4.times do 
          workout.intervals.build
        end
        workout.save
      end
    when "remove_interval"
      @workouts = Workout.where(:workoutdate => params[:date].to_time)
      if @workouts.any?
        workout =  @workouts[0]
        workout.intervals[params[:id].to_i].delete;
      else
        workout = Workout.new
        workout.workoutdate = params[:date]
        2.times do 
          workout.intervals.build
        end
        workout.save
      end
    else
    end
    @workouts = Workout.all
    @date = params[:month] ? Date.parse(params[:month].gsub('-', '/')) : Date.today
  end

  def update_multiple
    for @workoutdate in params[:workout_workoutdates]
      # Update each record
      is_new = false
      @workouts = Workout.where(:workoutdate => @workoutdate.to_time)
      if !@workouts.any?
        workout = Workout.new
        workout.workoutdate = @workoutdate
        is_new = true
      else
        workout = @workouts[0]
      end

      for i in 0..params[@workoutdate.to_time.strftime("%Y-%m-%d") + "_workout_interval_count"].to_i-1
        interval_name = params[@workoutdate.to_time.strftime("%Y-%m-%d") + "_interval_" + i.to_s + "_interval_name"]
        if interval_name.length != 0
          if is_new
            workout.intervals.build
            interval = workout.intervals[-1]
          else
            interval = workout.intervals[i]
          end
          interval.interval_name = interval_name
          interval.save
        elsif !is_new
          workout.intervals[i].delete
        end
      end
      
      if workout.intervals.length == 0
        if !is_new
          workout.delete
        end
      else
        workout.save
      end

    end 

    redirect_to(workouts_path, :notice => "Successfully Updated workouts")
    return
  end

  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
    redirect_to workouts_url, :notice => "Successfully destroyed workout."
  end

end
