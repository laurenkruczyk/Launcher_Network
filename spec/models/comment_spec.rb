require 'spec_helper'

describe Comment do
  let(:comment_valid) {Comment.new(body: "Your Website Sux", post_id: 1, user_id: 1)}
  let(:comment_invalid) {Comment.new(body: "", post_id: 1, user_id: 1)}
  let(:user_valid) {User.new(first_name: "test", last_name: "stuff", email: "blah@aol.com")}

  context 'validations' do
    it 'is valid when given valid attributes' do
      expect(comment_valid).to be_valid
      expect(comment_valid.errors).to be_blank
    end

    it 'is invalid if body is blank' do
      expect(comment_invalid).to be_invalid
      expect(comment_invalid.errors).to_not be_blank
    end

  end

  context 'associations' do

    it 'allows user to have many comments' do
      user_valid.comments << comment_valid
      expect(user_valid.comments).to include comment_valid
    end

  end


  end

end
