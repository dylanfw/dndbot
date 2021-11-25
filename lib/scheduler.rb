require "pry"
require "discordrb"


module Scheduler
  extend Discordrb::EventContainer
  extend Discordrb::Commands::CommandContainer

  DAYS_FORMAT = /^[MTWRFSU]+$/i
  ABBREVIATED_DAYS = {
    "M" => "Monday",
    "T" => "Tuesday",
    "W" => "Wednesday",
    "R" => "Thursday",
    "F" => "Friday",
    "S" => "Saturday",
    "U" => "Sunday"
  }
  ALPHA_EMOJI = [
    "\u{1F1E6}", "\u{1F1E7}", "\u{1F1E8}", "\u{1F1E9}", "\u{1F1EA}", "\u{1F1EB}", "\u{1F1EC}", "\u{1F1ED}", 
    "\u{1F1EE}", "\u{1F1EF}", "\u{1F1F0}", "\u{1F1F1}", "\u{1F1F2}", "\u{1F1F3}", "\u{1F1F4}", "\u{1F1F5}", 
    "\u{1F1F6}", "\u{1F1F7}", "\u{1F1F8}", "\u{1F1F9}", "\u{1F1FA}", "\u{1F1FB}", "\u{1F1FC}", "\u{1F1FD}", 
    "\u{1F1EE}" 
  ]

  command :schedule, {
    aliases: [:sched],
    description: "Create a quick poll to schedule next week's session. Provide an abbreviation for the days to choose from.\n\t\tDefaults to all days if none are given. Example: `.schedule MTWRFSU`"
  } do |event, days|
    days ||= "MTWRFSU"

    unless match = days.match(DAYS_FORMAT)
      event << "Invalid days provided: #{days}. Expected format `.schedule MTWRFSU`, `.schedule TWR`, etc."
    else
      selected_days = days.split("").map { |day| ABBREVIATED_DAYS[day] }
      options = selected_days.zip(ALPHA_EMOJI).to_h
      options_txt = options.map { |day, emoji| "#{emoji}: #{day}" }.join("\n")

      msg = event.channel.send_message <<~EOF
        @everyone When can you play next?
        
        #{options_txt}
      EOF

      options.each { |_, emoji| msg.react(emoji) }
    end
    nil
  end

end
