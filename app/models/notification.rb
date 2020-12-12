# == Schema Information
#
# Table name: notifications
#
#  id              :integer          not null, primary key
#  confirmed_at    :datetime
#  notifiable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notifiable_id   :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_notifications_on_notifiable_type_and_notifiable_id  (notifiable_type,notifiable_id)
#  index_notifications_on_user_id                            (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :user
end
