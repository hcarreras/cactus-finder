class SmsSender
  attr_reader :client

  FROM = ENV["TWILIO_PHONE_NUMBER"].freeze
  TO = ENV["SMS_RECEIVER_PHONE_NUMBER"].freeze

  def initialize
    @client = Twilio::REST::Client.new(ENV["TWILIO_ACCOUNT_SID"], ENV["TWILIO_AUTH_TOKEN"])
  end

  def send
    client.messages.create(
      from: FROM,
      to: TO,
      body: "There is a new listing"
    )
  end
end
