require "spec_helper"

describe UserMailer do
  describe "profile_claim" do
  	let(:profile_claim) { Factory(:profile_claim) }
  	let(:mail) { UserMailer.profile_claim(profile_claim) }

  	
  end
end
