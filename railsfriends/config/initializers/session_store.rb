# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store, key: '_your_app_session', same_site: :none, secure: false
