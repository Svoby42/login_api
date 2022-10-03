require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome" do
    let(:user) { FactoryBot.create(:user) }
    let(:mail) { UserMailer.welcome(user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Vítejte")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["noreply@#{ENV['DOMAIN']}"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to be_present
    end
  end

end
