require 'rubygems'
require 'twilio-ruby'

class MessengerService
  def initialize
    # put your own credentials here
    account_sid = 'XXX'
    auth_token = 'YYY'

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token
  end

  def send_sms(from, to, msg)
    @client.messages.create(
      from: from,
      to: to,
      body: msg
    )
  end
end
