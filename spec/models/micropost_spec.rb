require 'spec_helper'

describe Micropost do

    let(:user){ FactoryGirl.create(:user)}

    before {@micropost = user.microposts.build(content: 'micropost content')}

    subject {@micropost}

    it { should respond_to(:content)}
    it { should respond_to(:user_id)}
    it { should respond_to(:user)}
    its(:user) { should eq user }

    it { should be_valid }

  describe "a micropost must be associated with a user" do
    before { @micropost.user_id = nil}
    it { should_not be_valid}
  end

  describe "with blank content" do
    before {@micropost.content = ''}

    it {expect(@micropost).to be_invalid}
  end

  describe "with content larger than 140 characters" do
    before {@micropost.content = 'c'*141}

    it {expect(@micropost).to be_invalid}
  end
end
