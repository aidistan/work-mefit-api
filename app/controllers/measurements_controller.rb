class MeasurementsController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_measurement, only: %i[show update destroy]

  def index
    @measurements = policy_scope(@user.measurements)
  end

  def show
  end

  def create
    authorize @measurement = @user.measurements.build(measurement_params)

    if @measurement.save
      render :show, status: :created
    else
      render json: @measurement.errors, status: :unprocessable_entity
    end
  end

  def update
    if @measurement.update(measurement_params)
      render :show, status: :ok
    else
      render json: @measurement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @measurement.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_measurement
    authorize @measurement = Measurement.find(params[:id])
  end

  def measurement_params
    params.require(:measurement).permit(:gender, :age, :height, :weight, :activity_level)
  end
end
