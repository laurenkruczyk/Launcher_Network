require 'spec_helper'

describe InterestGroup do

  let(:valid_attributes) do {
      name: 'Lauren',
      description: 'yay!'
    }
  end

  let(:interest_group_valid) {InterestGroup.create!(valid_attributes)}
  let(:interest_group_blank_name) {InterestGroup.new(name: '')}
  let(:interest_group_number_name) {InterestGroup.new(name: '44535')}
  let(:user) {User.create!(first_name: "string", last_name: "string", email: "string@aol.com")}
  let(:interest_group_description) {InterestGroup.new(name: "I'm a String", description: '')}
  let(:post) {Post.new(title: 'first post', body: 'text', date_created: Time.now, user_id: 1)}
  let(:post2) {Post.new(title: 'second post', body: 'text', date_created: Time.now, user_id: 1)}
  let(:post3) {Post.new(title: 'third post', body: 'text', date_created: Time.now, user_id: 1)}

  context 'Validations' do
    it "is valid when it has all valid attributes" do
      expect(interest_group_valid).to be_valid
      expect(interest_group_valid.errors).to be_blank
    end

    it 'requires a name' do
      expect(interest_group_blank_name).to_not be_valid
      expect(interest_group_blank_name.errors).to_not be_blank
    end

    it "is invalid when name has numbers" do
      expect(interest_group_number_name).to_not be_valid
      expect(interest_group_number_name.errors).to_not be_blank
    end

    it 'optionally takes a description' do
      expect(interest_group_description).to be_valid
      expect(interest_group_description.errors).to be_blank
    end

  end

  context 'user associations' do
    it 'can take in members' do
      interest_group_valid.users << user
      expect(interest_group_valid.users).to include user
    end

    # it 'should have a creator' do
    # # create a User object
    # creator_attributes = {
    #   first_name: "Barry",
    #   last_name: "Zuckercorn",
    #   email: "barry@hesverygood.com"
    # }
    # creator = User.create(creator_attributes)

    # # create an InterestGroup object with that user object as the creator
    # group_attributes = {
    #   name: "Excuses",
    #   creator: creator
    # }
    # group = InterestGroup.create(group_attributes)

    # expect(group.creator).to eq creator
    # end
  end

  context 'post and comment associations through instance methods' do
    it 'counts the number of posts in the group' do
       post = Post.new(title: 'this post', body: 'text', date_created: Time.now, user_id: 1)
       interest_group_valid.posts << post
       expect(interest_group_valid.count_posts).to be(1)
    end

    it 'counts the top three most popular posts based on comments' do
      interest_group_valid.posts << post
      interest_group_valid.posts << post2
      interest_group_valid.posts << post3

      3.times do
        post.comments << Comment.new(body: 'words', user_id: 1)
        post2.comments << Comment.new(body: 'yikes', user_id: 1)
      end

      2.times do
        post3.comments << Comment.new(body: 'Commmmments', user_id: 1)
      end

      expect(interest_group_valid.top_3_posts).to eq({"first post"=>3, "second post"=>3, "third post"=>2})
    end

  end
end
