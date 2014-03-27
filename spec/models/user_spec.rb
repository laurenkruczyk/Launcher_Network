require 'spec_helper'

describe User do

  let(:valid_attributes) do {
      first_name: 'Lauren',
      last_name: 'Kruczyk',
      email: 'lauren@kruczyk.com'
    }
  end

  let(:user_valid) {User.new(valid_attributes)}
  # let(:post) {Post.new(title: 'first post', body: 'text', date_created: Time.now, interest_group_id: 1)}
  # let(:interest_group_valid) {InterestGroup.create!(name: "Daniel", description: "hi")}
  # let(:email_invalid) {User.new(first_name: "Daniel", last_name: "G", email: "afassdf")}
  # let(:user_blank_first) {User.new(first_name: "", last_name: "string", email: "string@aol.com")}
  # let(:user_blank_last) {User.new(first_name: "Daniel", last_name: "", email: "string@aol.com")}
  # let(:user_blank_email) {User.new(first_name: "Daniel", last_name: "G", email: "")}
  # let(:user_ee) {User.new(first_name: "string", last_name: "string", email: "string@aol.com", ee: true)}

  describe 'validations' do
    it 'is valid when it has all valid attributes' do
      expect(user_valid).to be_valid
      expect(user_valid.errors).to be_blank
    end

    it 'is invalid when first name empty' do
      user = User.new(valid_attributes.merge(first_name: ''))
      expect(user).to_not be_valid
      expect(user.errors[:first_name]).to include "can't be blank"
    end

    it 'is invalid when last name empty' do
      user = User.new(valid_attributes.merge(last_name: ''))
      expect(user).to_not be_valid
      expect(user.errors[:last_name]).to include "can't be blank"
    end

    it 'is invalid when email empty' do
      user = User.new(valid_attributes.merge(email: ''))
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include "can't be blank"
    end

    it 'allows for the user to be an ee' do
      user = User.new(valid_attributes.merge(ee: true))
      expect(user).to be_true
      expect(user.errors[:ee]).to be_blank
    end

    it 'does not allow repeat emails' do
      User.new(valid_attributes).save!
      user = User.new(valid_attributes.merge(email: 'daniel@daniel.com'))
      expect(user).to_not be_valid
      expect(user.errors[:email]).to include "has already been taken"
    end

    it 'only allows properly formatted emails' do
      user = User.new(valid_attributes.merge(email: '443.com'))
      expect(user).to_not be_valid
      expect(user.errors).to_not be_blank
    end

    context 'associations through instance methods' do
      it 'gives names of all the groups user belongs to' do
        user_valid.interest_groups << InterestGroup.new(name: "Daniel", description: "hi")
        expect(user_valid.groups).to eq(['Daniel'])
      end

      it 'counts number of post user made' do
        user_valid.posts << Post.new(title: 'first post', body: 'text', date_created: Time.now, interest_group_id: 1)
        user_valid.save!
        expect(user_valid.post_count).to eq(1)
      end

      it 'counts number of comments made' do
        user_valid.comments << Comment.new(body: 'Commmmments', post_id: 1, user_id: 1)
        user_valid.save!
        expect(user_valid.comment_count).to eq(1)
      end

    end




  end


end
