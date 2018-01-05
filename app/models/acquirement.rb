class Acquirement < ApplicationRecord
  belongs_to :user
  belongs_to :requirement

  validate do
    %i[calories fat protein carbohydrate].each do |sym|
      errors.add sym, :invalid unless send(sym) > 0
    end
  end
end
