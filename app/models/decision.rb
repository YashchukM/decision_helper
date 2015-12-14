class Decision < ActiveRecord::Base
  belongs_to :best_abs, class_name: 'Choice'
  belongs_to :best_user, class_name: 'Choice'
  belongs_to :best_balanced, class_name: 'Choice'

  has_many :choices, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 250 }
end
