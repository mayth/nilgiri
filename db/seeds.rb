# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:"

shell.say ""

account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if account.valid?
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{password}"
  shell.say "================================================================="
else
  shell.say "Sorry but some thing went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""

Machine.create(name: 'beatmania IIDX 21 SPADA', difficulties: %w(NORMAL HYPER ANOTHER), playstyles: %w(SP DP))
Machine.create(name: "pop'n music Sunny Park", difficulties: %w(NORMAL HYPER EX))
Machine.create(name: 'GITADORA GuitarFreaks', difficulties: %w(BASIC ADVANCED EXTREME MASTER), playstyles: %w(GUITAR BASS))
Machine.create(name: 'GITADORA DrumMania', difficulties: %w(BASIC ADVANCED EXTREME MASTER))
Machine.create(name: 'DanceDanceRevolution', difficulties: %w(BEGINNER BASIC DIFFICULT EXPERT CHALLENGE), playstyles: %w(SP DP))
Machine.create(name: 'jubeat saucer', difficulties: %w(BASIC ADVANCED EXTREME))
Machine.create(name: 'REFLEC BEAT colette', difficulties: %w(BASIC MEDIUM HARD))
Machine.create(name: 'SOUND VOLTEX II -infinite infection-', difficulties: %w(NOVICE ADVANCED EXHAUST INFINITE))
Machine.create(name: 'DanceEvolution ARCADE', difficulties: %w(LIGHT STANDARD EXTREME MASTER STEALTH))
Machine.create(name: 'ミライダガッキ', difficulties: %w(ベーシック スーパー ウルトラ))
Machine.create(name: 'maimai GreeN', difficulties: %w(EASY BASIC ADVANCED EXPERT MASTER))
