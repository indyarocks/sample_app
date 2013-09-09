include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

def sign_in(user, options = {})
  if options[:no_capybara]
    # Signin when not using capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Sign In"
  end
end

def fill_valid_signup_details
    fill_in "Name", with: "Chandan Kumar"
    fill_in "Email", with: "chandan.jhun@example.com"
    fill_in "Password", with: "foobar"
    fill_in "Confirmation", with: "foobar"
end

#def full_title(page_title)
#  base_title = "Ruby on Rails Tutorial Sample App"
#  if page_title.blank?
#    base_title
#  else
#    "#{base_title} | #{page_title}"
#  end
#end