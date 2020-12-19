# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :active_relationships,  class_name: 'Follow', foreign_key: :user_id, dependent: :destroy
  has_many :passive_relationships, class_name: 'Follow', foreign_key: :target_user_id, dependent: :destroy
  has_many :following, through: :active_relationships, source: :target_user
  has_many :followers, through: :passive_relationships, source: :user

  def subscribed?(type)
    subscriptions.subscribed?(type)
  end

  def follow(other_user)
    active_relationships.find_or_create_by(target_user: other_user)
  end
end
