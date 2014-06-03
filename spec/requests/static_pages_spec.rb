require 'spec_helper'

describe "StaticPages" do

	describe "Home page" do
		it "should have the content 'gin and juice'" do
			visit '/static_pages/home'
			expect(page).to have_content('gin and juice')
		end
	end
	
	describe "Help page" do
		it "should have the content 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_content('help')
		end
	end

describe "About page" do
		it "should have the content 'About'" do
			visit '/static_pages/about'
			expect(page).to have_content('About')
		end
	end

end
