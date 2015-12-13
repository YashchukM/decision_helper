class Criterium < ActiveRecord::Base
  belongs_to :choice

  validates :importance, :valuation, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1,
                                                          less_than_or_equal_to: 10}
  validates :name, presence: true, length: { minimum: 5, maximum: 70 }
end
