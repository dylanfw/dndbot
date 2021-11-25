
# Dndbot

**Dndbot** is a Discord bot built for simplifying frequent tasks performed in our Dungeons & Dragons Discord server.

Primarily built to make creating polls for weekly game scheduling as fast and simple as possible.



## Commands

**Weekly Scheduling**, .schedule (alias: .sched)

Quickly create a simple poll to select a day of the week.
Options are provided as single-letter abbreviated days of the week (MTWRFSU) and 
votes are placed via reactions. 

*The bot will tag `@everyone` when posting.*

```
<you> .schedule MWF
<Dndbot> @everyone When can you play next?

         🇦: Monday
         🇧: Wednesday
         🇨: Friday
        [🇦 1] [🇧 1] [🇨 1]


```

**Dice Rolling**, .roll (alias: .r)

Roll dice given the standard formula of XdY+Z.
The modifier portion *(+Z)* is optional and may be positive or negative.
```
<you> .roll 3d6+3
<Dndbot> You rolled (4) (1) (2) + 3 = 10
<you> .roll 1d20
<Dndbot> You rolled (18) = 18
```

**Status Updates**, .status

Update the bot's "Listening to" or "Playing" status. 
This change effects the bot in all servers that it is active in.

```
<you> .status listening Occam's Laser
*Dndbot is listening to Occam's Laser*

<you> .status playing Dungeons & Dragons
*Dndbot is playing Dungeons & Dragons*
```


## Running the Bot

Clone the project

```bash
  git clone git@github.com:dylanfw/dndbot.git
```

Go to the project directory

```bash
  cd dndbot
```

Create a `.env` file from the example

```bash
cp .env.example .env
```

[Create a Discord application](https://discord.com/developers/applications) 
and update the APP_ID and TOKEN values found in .env with the values for your
Discord application.

Install dependencies

```bash
  bundle install
```

Start the bot

```bash
  bundle exec ruby lib/dndbot.rb
```


## Roadmap

- "Unavailable" scheduling option
  - A default scheduling option for players that are unavailable for all given days
- Reminders for users that have not yet voted
  - Notify all users who have yet to vote, either automatically after some amount of time or manually via command (eg, `.nudge`)
- Custom poll creation
  - Allow creation of polls with custom questions and options rather than simply days of the week.
- D&D Session Notes integration
  - Given a Google Doc (configured in .env), share updates in the channel when substantial changes are made
## Authors

- [@dylanfw](https://www.github.com/dylanfw)

