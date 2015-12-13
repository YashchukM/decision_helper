module DecisionsHelper

  def evaluate(importance, value)
    result = Array.new(3)
    result[0] = getBestForUser(importance, value)
    result[1] = getBest(value)
    result[2] = getBalanced(importance, value)
    result
  end

  def getMax(values)
    max = 0
    maxValue = values[0]
    for i in (0..(values.size - 1))
      if (values[i] > maxValue)
        maxValue = values[i]
        max = i
      end
    end
    max
  end

  def getBestForUser(importance, value)
    result = Array.new(size=importance.size, 0)
    for i in (0..(importance.size - 1))
      result[i] += importance[i] * value[i];
    end
    getMax(result)
  end

  def getBest(value)
    result = Array.new(size = value.size, 0)
    for i in (0..(value.size - 1))
      result[i] += value[i];
    end
    getMax(result)
  end

  def getBalanced(importance, value)
    coef = 4
    result = Array.new(size=importance.size, 0)
    for i in (0..(importance.size - 1))
      if (value[i] < coef)
        result[i] -= (coef - value[i]) * importance[i];
      else
        result[i] += importance[i] * value[i]
      end
    end
    getMax(result)
  end

end
