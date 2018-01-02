class RequirementsController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_requirement, only: %i[show update destroy]

  def index
    @requirements = policy_scope(@user.requirements)
  end

  def show
  end

  def create
    authorize @requirement = @user.requirements.build(requirement_params)

    if @requirement.save
      render :show, status: :created
    else
      render json: @requirement.errors, status: :unprocessable_entity
    end
  end

  def update
    if @requirement.update(requirement_params)
      render :show, status: :ok
    else
      render json: @requirement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @requirement.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_requirement
    authorize @requirement = Requirement.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def requirement_params
    params.require(:requirement).permit(:formula, :calories, :fat, :protein, :carbohydrate, :measurement_id)
  end
end
