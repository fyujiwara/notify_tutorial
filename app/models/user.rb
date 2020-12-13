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

  def subscribed?(type)
    raise NotImplementedError unless Subscription.types.include?(type.to_s)

    subscriptions.exists?(type: type)
  end

end
