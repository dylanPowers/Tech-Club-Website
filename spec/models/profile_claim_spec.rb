# == Schema Information
#
# Table name: profile_claims
#
#  id         :integer          not null, primary key
#  email      :string(255)
#  profile_id :integer
#  token      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe ProfileClaim do
	describe "#send_profile_claim" do
		let(:profile_claim) { FactoryGirl.create(:profile_claim) }

		it "should deliver email to the user" do
			profile_claim.send_profile_claim
			last_email.to.should include(profile_claim.email)
		end
	end	

	describe "should be invalid when email" do
		before do
			@profile_claim = ProfileClaim.new()
		end

		subject { @profile_claim }

		it "is not present" do
			@profile_claim.email = ""
			should_not be_valid
		end

		it "is an unauthorized WSU subdomain" do
			@profile_claim.email = "example@myclub.wsu.edu"
			should_not be_valid
		end

		it "is not a wsu.edu domain" do
			addresses = ["example@examplewsu.edu", "example@wsu.edu.com", "example@wsu.com"]
			addresses.each do |invalid_address|
				@profile_claim.email = invalid_address
				should_not be_valid
			end
		end

		it "is incorrectly formatted" do
			@profile_claim.email = "butch@the@cougar@wsu.edu"
			should_not be_valid
		end

		it "is already used" do
			@profile_claim.email = "butch.cougar@wsu.edu"
			same_email = @profile_claim.dup
			same_email.save
			@profile_claim.email.upcase!
			should_not be_valid
		end
	end

	describe "should be valid when email" do
		it "is a valid domain" do
			@profile_claim = ProfileClaim.new()
			addresses = ["butch.cougar@wsu.edu", "butch.cougar@email.wsu.edu", "butch.cougar@eecs.wsu.edu"]
			addresses.each do |valid_address|
				@profile_claim.email = valid_address
				@profile_claim.should be_valid
			end
		end	
	end

	describe "with mixed-case email" do
		let(:mixed_case_email) { "Butch.Cougar@WSU.EDU" }
		it "should be saved as lowercase" do
			@profile_claim = ProfileClaim.new(email: mixed_case_email)
			@profile_claim.save
			@profile_claim.reload.email.should == mixed_case_email.downcase
		end
	end
end
