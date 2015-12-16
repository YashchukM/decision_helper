class DecisionsController < ApplicationController

  before_action :only_current, only: [:results, :update]

  def index
    @decisions = Decision.where('best_abs_id IS NOT NULL').limit(5).order('created_at desc')
  end

  def show
    @decision = Decision.find(params[:id])
    if creator_looks?(@decision)
      @choices = @decision.choices
    else
      render 'results'
    end
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

  def update
    if correct_input?
      logger.info 'Input is correct'
      params[:importance].each do |k, v|
        v.each { |kk, vv| Criterium.find(kk.to_i).update_attribute(:importance, vv.to_i) }
      end
      params[:valuation].each do |k, v|
        v.each { |kk, vv| Criterium.find(kk.to_i).update_attribute(:valuation, vv.to_i) }
      end

      evaluate
      redirect_to results_url
    else
      logger.info 'Input is incorrect'
      flash[:danger] = 'Input is incorrect'
      redirect_to current_decision
    end
  end

  def results
    @decision = current_decision
  end

  private

    def decision_params
      params.require(:decision).permit(:name)
    end

    def only_current
      redirect_to root_url if current_decision.nil?
    end

    def creator_looks?(decision)
      return true if !current_decision.nil? && current_decision.id == decision.id
      return false
    end
end
