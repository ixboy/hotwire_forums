class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }

  validates :name, presence: true
  after_create_commit -> { broadcast_prepend_to 'discussion' }
  after_update_commit -> { broadcast_replace_to 'discussion' }
  after_destroy_commit -> { broadcast_remove_to 'discussion' }

  def to_param
    "#{id}-#{name.downcase.to_s[0..100]}".parameterize
  end
end
