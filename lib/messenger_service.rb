require 'rubygems'
require 'twilio-ruby'

class MessengerService
  def initialize
    # put your own credentials here
    account_sid = 'AC12077148dd63a5d79e5e2531a1fdcbcb'
    auth_token = 'd184cc144faeb61d5585df80cc4bffea'

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
