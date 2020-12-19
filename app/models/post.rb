# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  body       :text             default(""), not null
#  title      :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Post < ApplicationRecord
  include Notifiable

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable

  def notify_recipients
    user.followers
  end

  def notify_title
    "新規記事の投稿がありました"
  end

  def notify_body
    "#{user.name}さんの新規記事の投稿がありました"
  end

end
