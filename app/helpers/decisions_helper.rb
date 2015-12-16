module DecisionsHelper

  def evaluate()
    getBestForUser()
    getBest()
    getBalanced()
  end

  def getMax(val)
    maxVal = val.values[0]
    max = val.keys[0]
    val.each do |k,v|
      if (v > maxVal)
        maxVal = v;
        max = k
      end
    end
    max
  end

  def getBestForUser()
    h = Hash.new
    params[:importance].each do |k, v|
      v.each { |kk, vv|
        if (h[kk] == nil)
          h[kk] = 0
        end
        h[kk] += vv.to_i * params[:valuation][kk].to_i
      }
    end
    current_decision.update_attribute(:best_user_id, getMax(h))
  end

  def getBest()
    h = Hash.new
    params[:importance].each do |k, v|
      v.each { |kk, vv|
        if (h[kk] == nil)
          h[kk] = 0
        end
        h[kk] += vv.to_i
      }
    end
    current_decision.update_attribute(:best_abs_id, getMax(h))
  end

  def getBalanced()
    coef = 4
    params[:importance].each do |k, v|
      v.each { |kk, vv|
        if (h[kk] == nil)
          h[kk] = 0
        end
        if (vv < coef)
          h[kk] -= (coef - vv.to_i) * params[:valuation][kk].to_i
        end
        h[kk] += vv.to_i * params[:valuation][kk].to_i
      }
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
    if (decision_id = session[:decision_id])
      @decision ||= Decision.find(decision_id)
    end
  end

  def correct_input?
    return false if params[:importance].nil? || params[:valuation].nil?
    params[:importance].each { |k, choice| return false if choice.empty? }
    params[:valuation].each { |k, choice| return false if choice.empty? }
    return true
  end

end
