# Create default admin account
email     = 'admin@example.com'
password  = 'password'
account = Account.create(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

# Create machines
Machine.create(name: 'beatmania IIDX 21 SPADA', difficulties: %w(NORMAL HYPER ANOTHER), playstyles: %w(SP DP), slug: 'iidx')
Machine.create(name: "pop'n music Sunny Park", difficulties: %w(NORMAL HYPER EX), slug: 'popn')
Machine.create(name: 'GITADORA GuitarFreaks', difficulties: %w(BASIC ADVANCED EXTREME MASTER), playstyles: %w(GUITAR BASS), slug: 'gf')
Machine.create(name: 'GITADORA DrumMania', difficulties: %w(BASIC ADVANCED EXTREME MASTER), slug: 'dm')
Machine.create(name: 'DanceDanceRevolution', difficulties: %w(BEGINNER BASIC DIFFICULT EXPERT CHALLENGE), playstyles: %w(SP DP), slug: 'ddr')
Machine.create(name: 'jubeat saucer', difficulties: %w(BASIC ADVANCED EXTREME), slug: 'jubeat')
Machine.create(name: 'REFLEC BEAT colette', difficulties: %w(BASIC MEDIUM HARD), slug: 'reflec')
Machine.create(name: 'SOUND VOLTEX II -infinite infection-', difficulties: %w(NOVICE ADVANCED EXHAUST INFINITE), slug: 'sdvx')
Machine.create(name: 'DanceEvolution ARCADE', difficulties: %w(LIGHT STANDARD EXTREME MASTER STEALTH), slug: 'dea')
Machine.create(name: 'ミライダガッキ', difficulties: %w(ベーシック スーパー ウルトラ), slug: 'ftt')
Machine.create(name: 'maimai GreeN', difficulties: %w(EASY BASIC ADVANCED EXPERT MASTER), slug: 'maimai')
