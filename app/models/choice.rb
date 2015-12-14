class Choice < ActiveRecord::Base
  belongs_to :decision

  has_many :criteriums, dependent: :destroy

  validates :name, presence: true, length: { minimum: 5, maximum: 100 }
end
