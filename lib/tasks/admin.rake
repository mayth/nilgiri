namespace :admin do
  desc "Add the user"
  task create_user: :environment do
    email = ENV['EMAIL'].presence
    raise "No email address. Specify `EMAIL'." unless email
    password = ENV['PASSWORD'].presence
    raise "No password. Specify `PASSWORD'." unless password
    User.create(email: email, password: password, password_confirmation: password)
  end
end
