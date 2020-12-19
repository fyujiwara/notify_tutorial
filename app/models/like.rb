# == Schema Information
#
# Table name: likes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_likes_on_post_id  (post_id)
#  index_likes_on_user_id  (user_id)
#
# Foreign Keys
#
#  post_id  (post_id => posts.id)
#  user_id  (user_id => users.id)
#
class Like < ApplicationRecord
  include Notifiable

  belongs_to :user
  belongs_to :post
  has_one :notification, as: :notifiable

  def notify_recipient
    post.user
  end

  def notify_title
    "あなたの記事が「いいね」されました"
  end

  def notify_body
    "#{user.name}があなたの記事を「いいね」と言っています"
  end
end
