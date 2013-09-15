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
      it { should_not have_content('Settings')}
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before {click_link "Home"}

        it { should_not have_error_message('Invalid')}
      end
    end

    describe "with valid information" do

      let(:user) {FactoryGirl.create(:user)}

      it { expect(user.email).not_to be_blank}
      it { expect(user.password).not_to be_blank}

      before {sign_in user}

      it { should have_content(user.name)}
      it { should have_link('Users', href: users_path)}
      it { should have_link('Profile', href: user_path(user))}
      it { should have_link('Settings', href: edit_user_path(user))}
      it { should have_link('Sign out', href: signout_path)}
      it { should_not have_link('Sign In', href: signin_path)}

      #describe "should redirect a logged in user to root url if user tries to hit new in users controller" do
      #  let(:user) {FactoryGirl.create(:user)}
      #  before do
      #    sign_in user
      #    get new_user_path
      #  end
      #
      #  specify{expect(response).to redirect_to(root_url)}
      #end
      #
      #describe "should redirect a logged in user to root url if user tries to hit create in users controller" do
      #  let(:params) do {user: {name: "Tester", email: "test@example.com", password: "password",
      #                          password_confirmation: "password"}}
      #  end
      #  let(:user) {FactoryGirl.create(:user)}
      #
      #  before do
      #    sign_in user
      #    post users_path, params
      #  end
      #
      #  specify{expect(response).to redirect_to(root_url)}
      #end

        describe "followed by signout" do
          before { click_link "Sign out"}
          it { should have_link("Sign In")}
        end
    end
  end

  describe "authorization" do

    describe "for non-signed in users" do
      let(:user) {FactoryGirl.create(:user)}

      describe "in the Users controller" do

        describe "visiting edit page" do
          before { visit edit_user_path(user)}

          it { should have_link("Sign In", href: signin_path)}
          it { should_not have_title("Edit user")}
          it { should_not have_content("Update your profile")}
          it { should_not have_link('Change', href: 'http://gravatar.com/emails')}
        end

        describe "submitting to update action" do
          before { patch user_path(user)}
          specify { expect(response).to redirect_to(signin_path)}
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title('Sign In')}
        end
      end

      describe "when attempting to visit a protected page" do

        before do
          visit edit_user_path(user)
          fill_in "Email", with: user.email
          fill_in "Password", with: user.password
          click_button "Sign In"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            expect(page).to have_title("Edit user")
          end

          describe "when signing in again" do
            before do
              delete user_path(user)
              sign_in user
            end

            it { should have_content(user.name)}
            it { should have_link('Users', href: users_path)}
            it { should have_link('Profile', href: user_path(user))}
            it { should have_link('Settings', href: edit_user_path(user))}
            it { should have_link('Sign out', href: signout_path)}
            it { should_not have_link('Sign In', href: signin_path)}
          end
        end
      end

      describe "in microposts controller" do

        describe "submitting to the create action" do
          let(:params) { {content: 'foobar', user_id: user.id} }

          before { post microposts_path, params}
          specify { expect(response).to redirect_to(signin_path)}
        end

        describe "when attempting to destroy a micropost" do
          let!(:micropost) {FactoryGirl.create(:micropost, user: user)}
          before {delete micropost_path(micropost)}

          specify { expect(response).to redirect_to(signin_path)}
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user)}
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com")}

      before { sign_in user, no_capybara: true}

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user)}

        it { should_not have_title(full_title("Edit user"))}
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user)}

        specify { expect(response).to redirect_to(root_url)}
      end
    end
  end
end
