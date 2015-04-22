# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  post_id    :integer          not null
#  author_id  :integer          not null
#  content    :text             not null
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ActiveRecord::Base
  validates :post_id, presence: true
  validates :author_id, presence: true
  validates :content, presence: true

  belongs_to :post
  belongs_to :author, class_name: 'User'

  has_many(
    :child_comments,
    class_name: 'Comment',
    foreign_key: :parent_comment_id,
    inverse_of: :parent_comment,
    dependent: :destroy
  )

  belongs_to(
    :parent_comment,
    foreign_key: :parent_comment_id,
    inverse_of: :parent_comment,
    class_name: 'Comment'
  )
end
