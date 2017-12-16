class User < ApplicationRecord
  has_and_belongs_to_many :roles, join_table: :users_roles

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

  # rubocop:disable Naming/PredicateName
  def has_role?(required_role)
    roles.exists?(name: required_role)
  end

  def has_any_role?(*required_roles)
    roles.exists?(name: required_roles.flatten)
  end

  def has_all_roles?(*required_roles)
    required_roles = required_roles.flatten.uniq
    roles.where(name: required_roles).uniq.size == required_roles.size
  end
  # rubocop:enable Naming/PredicateName
end
