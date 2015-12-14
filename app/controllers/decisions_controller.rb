class DecisionsController < ApplicationController
  def index

  end

  def show
    @decision = Decision.find(params[:id])
    @choices = @decision.choices
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      remember_decision(@decision)
      flash[:info] = 'First step finished - you have stated your decision'
      redirect_to decision_url(@decision)
    else
      render 'new'
    end
  end

  def new
    @decision = Decision.new
  end

  private

    def decision_params
      params.require(:decision).permit(:name)
    end
end
