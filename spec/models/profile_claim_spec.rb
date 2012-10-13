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

		it "delivers email to user" do
			profile_claim.send_profile_claim
			last_email.to.should include(profile_claim.email)
		end
	end	
end
