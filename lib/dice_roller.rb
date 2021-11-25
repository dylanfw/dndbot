require "discordrb"

MAX_COUNT = 99
MAX_SIZE = 9001
FORMULA_PATTERN = /(\d+)d(\d+)([\+-]\d+)?/

module DiceRoller
  extend Discordrb::Commands::CommandContainer

  command :roll, {
    aliases: [:r],
    description: "Roll dice given a formula with an optional modifier. Example: `.roll 2d10+3`"
  } do |event, formula|
    unless match = formula.match(FORMULA_PATTERN)
      event << "I don't recognize that dice roll format."
    else
      count = match.captures[0].to_i
      size = match.captures[1].to_i
      modifier = match.captures[2].to_i

      # Ignore ridiculous dice roll requests
      if count > MAX_COUNT
        event << "I don't have that many dice."
        return nil
      elsif size > MAX_SIZE
        event << "I don't have any dice that large."
        return nil
      end

      rolls = (0...count).map { rand(1..size) }
      msg_parts = [
        "You rolled",
        *rolls.map { |roll| "(#{roll})" },
        modifier > 0 ? "+ #{modifier}" : nil,
        modifier < 0 ? "- #{modifier}" : nil,
        "= #{rolls.sum + modifier}"
      ]

      event.bot.send_message(
        channel=event.channel,
        content=msg_parts.reject{ |s| s.nil? }.join(" "),
        # message_reference=event.message   # TODO: Fix 400 error
      )
    end
  end
end
