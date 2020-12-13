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
#  recipient_id    :integer          not null
#
# Indexes
#
#  index_notifications_on_notifiable_type_and_notifiable_id  (notifiable_type,notifiable_id)
#  index_notifications_on_recipient_id                       (recipient_id)
#
# Foreign Keys
#
#  recipient_id  (recipient_id => users.id)
#
class Notification < ApplicationRecord
  belongs_to :notifiable, polymorphic: true
  belongs_to :recipient, class_name: 'User'
end
