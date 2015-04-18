# == Schema Information
#
# Table name: post_subs
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  sub_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class PostSub < ActiveRecord::Base
  validates :sub_id, presence: true, uniqueness: {scope: :post_id}
  validates :post, presence: true, uniqueness: {scope: :sub_id}

  belongs_to :post
  belongs_to :sub
  has_one :moderator, through: :sub

end
