# == Schema Information
#
# Table name: subscriptions
#
#  id         :integer          not null, primary key
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_subscriptions_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :subscription do
    user
    type { Subscription.types.keys.sample }
  end
end
