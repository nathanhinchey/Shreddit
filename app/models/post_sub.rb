# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  sub_id     :integer          not null
#  post_id    :integer          not null
#

class PostSub < ActiveRecord::Base
  validates :sub_id, presence: true, uniqueness: {scope: :post_id}
  validates :post_id, presence: true, uniqueness: {scope: :sub_id}

  belongs_to :post
  belongs_to :sub
  has_one :moderator, through: :sub

end
