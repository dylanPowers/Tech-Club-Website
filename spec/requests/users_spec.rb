require 'spec_helper'

describe "Users" do
	subject { page }

	describe "who join" do		
		before {visit join_path}

		describe "with an invalid email address" do
			let(:submit) {"Create Profile claim"}

			it "should not create a profile claim" do
				expect {click_button submit}.not_to change(ProfileClaim, :count)
			end
			it "should not send an email" do
				last_email.should be_nil
			end
		end

		describe "with an @email.wsu.edu email address" do
			before do
				fill_in "Email", with: "butch.thecougar@email.wsu.edu"
			end
			it "should create a profile claim" do
				expect { click_button submit }.to change(ProfileClaim, :count).by(1)
			end
			it "should send an email" do
				last_email.to.should include(user.email)
			end
		end
	end
end
