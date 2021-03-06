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
require 'rails_helper'

RSpec.describe Notification, type: :model do

  describe '##deliver' do
    let!(:recipient) { FactoryBot.create(:user) }

    context '投稿した記事にいいねされた場合' do
      let!(:post) { FactoryBot.create(:post, user: recipient) }
      let(:like){ FactoryBot.create(:like, post: post) }

      context 'いいねの通知を許可している場合' do
        let!(:subscription){ FactoryBot.create(:subscription, user: recipient, subscription_type: :like) }

        it '通知が来ること' do
          expect { Notification.deliver(like, :like) }.to change {
            recipient.notifications.count
          }.by(1)
        end
      end

      context 'いいねの通知を許可していない場合' do
        it '通知が来ないこと' do
          expect(Notification.deliver(like, :like)).to be_falsey
        end
      end
    end

    context '投稿した記事にコメントされた場合' do
      let!(:post) { FactoryBot.create(:post, user: recipient) }
      let(:comment){ FactoryBot.create(:comment, post: post) }

      context 'コメントの通知を許可している場合' do
        let!(:subscription){ FactoryBot.create(:subscription, user: recipient, subscription_type: :comment) }

        it '通知が来ること' do
          expect { Notification.deliver(comment, :comment) }.to change {
            recipient.notifications.count
          }.by(1)
        end
      end
      context 'コメントの通知を許可していない場合' do
        it '通知が来ないこと' do
          expect(Notification.deliver(comment, :comment)).to be_falsey
        end
      end
    end

    context 'フォローされた場合' do
      let(:follow){ FactoryBot.create(:follow, target_user: recipient) }

      context 'フォローの通知を許可している場合' do
        let!(:subscription){ FactoryBot.create(:subscription, user: recipient, subscription_type: :follow) }

        it '通知が来ること' do
          expect { Notification.deliver(follow, :follow) }.to change {
            recipient.notifications.count
          }.by(1)
        end
      end
      context 'フォローの通知を許可していない場合' do
        it '通知が来ないこと' do
          expect(Notification.deliver(follow, :follow)).to be_falsey
        end
      end
    end
  end

  describe '##deliver_all' do
    context 'フォローしているユーザーが記事を投稿した場合' do
      let(:following_user){ FactoryBot.create(:user) }
      let(:recipient_01){ FactoryBot.create(:user) }
      let(:recipient_02){ FactoryBot.create(:user) }
      let!(:follow_01){ FactoryBot.create(:follow, user: recipient_01, target_user: following_user) }
      let!(:follow_02){ FactoryBot.create(:follow, user: recipient_02, target_user: following_user) }
      let(:post){ FactoryBot.create(:post, user: following_user) }

      context '新規投稿の通知を許可している場合' do
        let!(:subscription_01){ FactoryBot.create(:subscription, user: recipient_01, subscription_type: :post) }
        let!(:subscription_02){ FactoryBot.create(:subscription, user: recipient_02, subscription_type: :post) }

        it '全てのユーザーに通知が来ること' do
          expect(Notification.deliver_all(post, :post)).to eq 2
        end
      end
      context '新規投稿の通知を許可していない場合' do
        it '通知が来ないこと' do
          expect(Notification.deliver_all(post, :post)).to eq 0
        end
      end
    end
  end
end
