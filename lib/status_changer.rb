require "discordrb"

module StatusChanger
  extend Discordrb::Commands::CommandContainer

  command :status, {
    description: "Update the bot's status.\n\t\t`.status playing Dungeons & Dragons`\n\t\t`.status listening Occam's Laser`"
  } do |event, type, *value|
    value = value.join " "

    if type == "playing"
      value = value.length > 0 ? value : "Dungeons & Dragons"
      event.bot.playing = value
    elsif type == "listening"
      value = value.length > 0 ? value : "Occam's Laser"
      event.bot.listening = value
    else
      event << "Unrecognized status type: #{type}. Expected either \"playing\" or \"listening\"."
    end

    nil
  end
end
