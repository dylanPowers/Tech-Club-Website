require 'spec_helper'

describe "Users" do
	subject { page }

	describe "who join" do		
		before {visit join_path}
		let(:submit) { "Create Profile claim" }
		let(:profile_claim) { FactoryGirl.create(:profile_claim) }

		describe "with an invalid email address" do
			it "should not create a profile claim" do
				expect {click_button submit}.not_to change(ProfileClaim, :count)
			end
			it "should not send an email" do
				click_button submit
				last_email.should be_nil
			end
		end

		describe "with an @email.wsu.edu email address" do
			before do
				fill_in "Email", with: profile_claim.email
			end
			it "should create a profile claim" do
				expect { click_button submit }.to change(ProfileClaim, :count).by(1)
			end
			it "should send an email" do
				click_button submit
				last_email.should_not be_nil
				last_email.to.should include(profile_claim.email)
			end
		end
	end
end
