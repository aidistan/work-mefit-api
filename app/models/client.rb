class Client < ApplicationRecord
  validates :codename, presence: true, uniqueness: true, length: { maximum: 64 }
  validates :redirect_uri, presence: true, uri: { query: false }, allow_nil: true

  before_create do
    self.uuid = UUIDTools::UUID.timestamp_create
    self.secret = UUIDTools::UUID.random_create
  end
end
