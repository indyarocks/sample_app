require 'spec_helper'

describe "Static Pages" do
  let(:title_first) {"Ruby on Rails Tutorial Same App"}

  describe "Home page" do
    it "should have the content 'Sample App' " do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit '/static_pages/home'
      expect(page).to have_content('Sample App')
    end

    it "should have the base title" do
    	visit '/static_pages/home'
    	expect(page).to have_title(title_first)
    end	

    it "should not have a custom page title" do
      visit '/static_pages/home'
      expect(page).not_to have_title('| Home')
    end
  end

  describe "Help Page" do
    let(:title_last) {"Help"}
    
    it "should have the content, 'Help' " do
    	visit '/static_pages/help'
    	expect(page).to have_content('Help')
    end

    it "should have the right title" do
    	visit '/static_pages/help'
      expect(page).to have_title("#{title_first} | #{title_last}")
    end	
  end  

  describe "About page" do
    let(:title_last) {"About Us"}

  	it "should have content 'About Us'" do
  		visit '/static_pages/about'
  		expect(page).to have_content('About Us')
  	end

  	it "should have the right title" do
    	visit '/static_pages/about'
      expect(page).to have_title("#{title_first} | #{title_last}")
    end	
  end

  describe "Contact page" do
    let(:title_last){"Contact Us"}

    it "should have content'Contact Us'" do
      visit '/static_pages/contact'
      expect(page).to have_content('Contact Us')
    end

    it "should have right title" do
      visit '/static_pages/contact'
      expect(page).to have_title("#{title_first} | #{title_last}")
    end
  end
end