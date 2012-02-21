require './boot'
require 'cinch'

DEFAULT_CHANNEL = '#gurupi'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = 'irc.freenode.net'
    c.channels = [DEFAULT_CHANNEL]
  end

  on :message, /^!add (.+)/ do |m, msg|
    Quote.create :added_nick => m.user.nick, :quote => msg
    m.reply 'Quote adicionado com sucesso.'
  end

  on :message, /^!quote (.+)/ do |m, nick|
    ch = Channel DEFAULT_CHANNEL
    quotes = Quote.where('quote like ?', "%#{nick}%").to_a
    ch.send quotes[rand(quotes.count)].quote
  end

  on :message, '!count' do |m|
    m.reply "Quote: #{Quote.count}"
  end
end

bot.start
