class InterestGroup < ActiveRecord::Base
  has_many :user_interest_groups
  has_many :users, through: :user_interest_groups
  has_many :posts

  validates :name, presence: true, format: { with: /[a-z]/i }, length: { minimum: 1 }

  def count_posts
    self.posts.count
  end

  def top_3_posts
    top = Hash.new(0)
    self.posts.each do |post|
      comment_count = post.comments.count
      top[post.title] = comment_count
    end
    top
  end


end
