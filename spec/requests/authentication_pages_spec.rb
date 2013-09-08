require 'spec_helper'

describe "Authentication" do
  subject { page }

  let(:submit) {"Sign In"}

  describe "signin page" do
    before { visit signin_path }

    it { should have_content("Sign In")}
    it { should have_title(full_title('Sign In'))}
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button submit }

      it { should have_title('Sign In')}
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before {click_link "Home"}

        it { should_not have_error_message('Invalid')}
      end
    end

    describe "with valid information" do

      user = FactoryGirl.create(:user)

      it { expect(user.email).not_to be_blank}
      it { expect(user.password).not_to be_blank}

      before {valid_signin user}

      it { should have_content(user.name)}
      it { should have_link('Profile', href: user_path(user))}
      it { should have_link('Sign out', href: signout_path)}
      it { should_not have_link('Sign In', href: signin_path)}

        describe "followed by signout" do
          before { click_link "Sign out"}
          it { should have_link("Sign In")}
        end
    end
  end
end
