# == Schema Information
#
# Table name: follows
#
#  id             :integer          not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  target_user_id :integer          not null
#  user_id        :integer          not null
#
# Indexes
#
#  index_follows_on_target_user_id  (target_user_id)
#  index_follows_on_user_id         (user_id)
#
# Foreign Keys
#
#  target_user_id  (target_user_id => users.id)
#  user_id         (user_id => users.id)
#
class Follow < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :target_user, class_name: 'User'
  has_one :notification, as: :notifiable

  validates :user_id,
            uniqueness: { scope: :target_user_id, message: 'has already been followed target user' },
            exclusion: { in: ->(follow) { [follow.target_user_id] }, message: 'must be different from target user'}

  def self.follow(user:, target_user:)
    create(user: user, target_user: target_user)
  end

  def notify_recipient
    target_user
  end

  def notify_title
    "フォローされました"
  end

  def notify_body
    "#{user.name}さんからフォローされました"
  end

end
