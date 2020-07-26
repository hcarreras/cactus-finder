require 'rails_helper'

describe SmsSender, type: :service do
  describe "send" do
    it "contacts Twilio API" do
      twilio_client_double = instance_double(Twilio::REST::Client)
      messages_double = instance_double(Twilio::REST::Api::V2010::AccountContext::MessageList )
      allow(Twilio::REST::Client).to receive(:new).and_return(twilio_client_double)
      allow(twilio_client_double).to receive(:messages).and_return(messages_double)
      allow(messages_double).to receive(:create)

      SmsSender.new.send

      expect(Twilio::REST::Client).to have_received(:new)
      expect(twilio_client_double).to have_received(:messages)
      expect(messages_double).to have_received(:create).with(
        from: "+1111111111",
        to: "+4533333333",
        body: "There is a new listing"
      )
    end
  end
end
