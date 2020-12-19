# == Schema Information
#
# Table name: subscriptions
#
#  id                :integer          not null, primary key
#  subscription_type :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer          not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Subscription < ApplicationRecord
  belongs_to :user

  enum subscription_type: { comment: 0, like: 1, follow: 2 }

end
