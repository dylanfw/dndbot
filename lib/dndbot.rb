require "dotenv/load"
require "discordrb"

require_relative "dice_roller"
require_relative "status_changer"
require_relative "scheduler"


bot = Discordrb::Commands::CommandBot.new(
  client_id: ENV["APP_ID"],
  token: ENV["TOKEN"],
  prefix: '.',
  ignore_bots: true,
  fancy_log: true
)

bot.include! Scheduler
bot.include! StatusChanger
bot.include! DiceRoller

at_exit { bot.stop }
bot.run(true)
bot.playing = "Dungeons & Dragons"
bot.join
