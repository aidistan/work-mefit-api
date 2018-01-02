class Requirement < ApplicationRecord
  belongs_to :user
  belongs_to :measurement

  validates :formula, presence: true
  validate do
    %i[calories fat protein carbohydrate].each do |sym|
      errors.add sym, :invalid unless send(sym) > 0
    end
  end
end
