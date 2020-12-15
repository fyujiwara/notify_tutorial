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
FactoryBot.define do
  factory :follow do
    association :user
    association :target_user, factory: :user
  end
end
