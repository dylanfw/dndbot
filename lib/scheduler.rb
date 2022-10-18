require "discordrb"

DayOption = Struct.new(:initial, :name, :emoji)

module Scheduler
  extend Discordrb::EventContainer
  extend Discordrb::Commands::CommandContainer
  DAYS_FORMAT = /^[MTWRFSU]+$/i
  DAYS_OPTIONS = {
    "M" => DayOption.new("M", "Monday", "\u{1F1F2}"),
    "T" => DayOption.new("T", "Tuesday", "\u{1F1F9}"),
    "W" => DayOption.new("W", "Wednesday", "\u{1F1FC}"),
    "R" => DayOption.new("R", "Thursday", "\u{1F1F7}"),
    "F" => DayOption.new("F", "Friday", "\u{1F1EB}"),
    "S" => DayOption.new("S", "Saturday", "\u{1F1F8}"),
    "U" => DayOption.new("U", "Sunday", "\u{1F1FA}")
  }
  UNAVAILABLE_OPTION = {"Unavailable" => DayOption.new("X", "Unavailable", "\u{1F645}")}

  command :schedule, {
    aliases: [:sched],
    description: "Create a quick poll to schedule next week's session. Provide an abbreviation for the days to choose from.\n\t\tDefaults to all days if none are given. Example: `.schedule MTWRFSU`"
  } do |event, days|
    days ||= "MTWRFSU"

    unless match = days.match(DAYS_FORMAT)
      event << "Invalid days provided: #{days}. Expected format `.schedule MTWRFSU`, `.schedule TWR`, etc."
    else
      options = days.split("").map { |day| DAYS_OPTIONS[day.upcase] }
      options = options.merge(UNAVAILABLE_OPTION)
      options_txt = options.map { |day| "#{day.emoji}: #{day.name}" }.join("\n")

      msg = event.channel.send_message <<~EOF
        @everyone When can you play next?
        
        #{options_txt}
      EOF

      options.each { |day| msg.react(day.emoji) }
    end
    nil
  end

end
