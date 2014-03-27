class User < ActiveRecord::Base
  has_many :user_interest_groups
  has_many :interest_groups, through: :user_interest_groups

  has_many :posts
  has_many :comments

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, on: :create }, uniqueness: true

  def groups
    groups = []
    self.interest_groups.each do |interest_group|
      groups << interest_group.name
    end
    groups
  end

  def post_count
    self.posts.count
  end

  def comment_count
    self.comments.count
  end

end
