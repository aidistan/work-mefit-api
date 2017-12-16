class User < ApplicationRecord
  enum gender: { female: 0, male: 1, unknown: 2 }
  has_secure_password

  validates :mobile, mobile: true, uniqueness: true, allow_nil: true
  validates :nickname, uniqueness: true, allow_nil: true
  validates :password, presence: true, allow_nil: true
  validates :weixin_id, uniqueness: true, allow_nil: true

  # Must have one identifer at least
  validate do
    # Only add to :mobile for error display
    errors.add :mobile, :blank if mobile.nil? && weixin_id.nil?
  end
end
