# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_baby_names_session',
  :secret      => 'bcab8b084109b0a3ed74b71f4e57a28c1b17d237574d40e06c66b41b6ad79cf9327487a20bbeac3ef1354e73e83219fcd8ca705c631ec77908f490fd6eda961b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
