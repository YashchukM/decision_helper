class ChoicesController < ApplicationController
  def create
    @choice = current_decision.choices.build(choice_params)
    if @choice.save
      flash[:info] = 'New choice added successfully'
      redirect_to current_decision
    else
      render 'new'
    end
  end

  def new
    @choice = current_decision.choices.build
  end

  private

    def choice_params
      params.require(:choice).permit(:name)
    end
end
