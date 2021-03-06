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
require 'rails_helper'

RSpec.describe Follow, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
