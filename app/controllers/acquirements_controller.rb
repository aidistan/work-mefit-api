class AcquirementsController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_acquirement, only: %i[show update destroy]

  def index
    @acquirements = policy_scope(@user.acquirements)
  end

  def show
  end

  def create
    authorize @acquirement = @user.acquirements.build(acquirement_params)

    if @acquirement.save
      render :show, status: :created
    else
      render json: @acquirement.errors, status: :unprocessable_entity
    end
  end

  def update
    if @acquirement.update(acquirement_params)
      render :show, status: :ok
    else
      render json: @acquirement.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @acquirement.destroy
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_acquirement
    authorize @acquirement = Acquirement.find(params[:id])
  end

  def acquirement_params
    params.require(:acquirement).permit(:calories, :fat, :protein, :carbohydrate, :requirement_id)
  end
end
