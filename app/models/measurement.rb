class Measurement < ApplicationRecord
  belongs_to :user

  enum gender: { female: 0, male: 1, unknown: 2 }

  validates :gender, presence: true
  validate do
    %i[age height weight activity_level].each do |sym|
      errors.add sym, :invalid unless send(sym) > 0
    end
  end
end
