# Create default admin account
email     = 'admin@example.com'
password  = 'password'
account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

# Create machines
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
