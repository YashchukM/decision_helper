class CriteriumsController < ApplicationController

  def create
    @criterium = Criterium.new(criterium_params)
    @criterium.importance = @criterium.valuation = 5
    if @criterium.save
      flash[:info] = 'New criterium added successfully'
      redirect_to current_decision
    else
      render 'decisions/new'
    end
  end

  def new
    @criterium = Choice.find(params[:choice_id]).criteriums.build
  end

  private

    def criterium_params
      params.require(:criterium).permit(:name, :choice_id)
    end
end
