module DecisionsHelper

  def evaluate()
    getBestForUser()
    getBest()
    getBalanced()
  end

  def getMax(val)
    maxVal = val.values[0]
    max = val.keys[0]
    val.each { |k,v| maxVal = v, max = k if v > maxVal }
    max
  end

  def getBestForUser()
    h = Hash.new(0)
    params[:importance].each { |k, v| v.each { |kk, vv| h[k] += vv.to_i * params[:valuation][kk].to_i } }
    current_decision.update_attribute(:best_user_id, getMax(h))
  end

  def getBest()
    h = Hash.new(0)
    params[:importance].each { |k, v| v.each { |kk, vv| h[k] += vv.to_i } }
    current_decision.update_attribute(:best_abs_id, getMax(h))
  end

  def getBalanced()
    h = Hash.new(0)
    coef = 4
    params[:importance].each do |k, v|
      v.each do |kk, vv|
        h[k] -= (coef - vv.to_i) * params[:valuation][kk].to_i if vv.to_i < coef
        h[k] += vv.to_i * params[:valuation][kk].to_i
      end
    end
    current_decision.update_attribute(:best_balanced_id, getMax(h))
  end

  def remember_decision(decision)
    session[:decision_id] = decision.id
  end

  def forget_decision
    session[:decision_id] = nil
  end

  def current_decision
    decision_id = session[:decision_id]
    unless (decision_id.nil?)
      @decision = Decision.find(decision_id)
    else
      nil
    end
  end

  def correct_input?
    return false if params[:importance].nil? || params[:valuation].nil?
    params[:importance].each { |k, choice| return false if choice.empty? }
    params[:valuation].each { |k, choice| return false if choice.empty? }
    return true
  end

end
