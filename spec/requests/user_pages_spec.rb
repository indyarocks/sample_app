require 'spec_helper'

describe "User Pages" do
	
  subject { page }

  describe "Signup Page" do
  	before { visit signup_path }
    
    it { should have_content('Sign Up')}

    it { should have_title(full_title('Sign Up'))}
      
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user)}

    before { visit user_path(user)}
    it { should have_content(user.name)}
    it { should have_title(user.name)}
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) {"Create my account"}

    describe "with invalid information" do
      it "should not create a user" do
        expect {click_button submit}.not_to change(User, :count)
      end

      describe "after submission" do
        before do
          fill_in "Name", with: ""
          fill_in "Email", with: "chandan.jhun@gmail.com"
          fill_in "Password", with: "foobar"
          fill_in "Confirmation", with: "foobar"
          click_button submit
        end
        it { should have_content("Name can't be blank")}

      end
    end

    describe "with valid information" do
      before do 
        fill_in "Name", with: "Chandan Kumar"
        fill_in "Email", with: "chandan.jhun@gmail.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      describe "after submission" do
        before { click_button submit}
        let(:user) {User.find_by(email: "chandan.jhun@gmail.com")}

        it { should have_title(user.name)}
        it { should have_selector('div.alert.alert-success', text: "Welcome")}
        #expect {click_button submit}.to change(User, :count).by(1)
      end  
    end
  end
end
