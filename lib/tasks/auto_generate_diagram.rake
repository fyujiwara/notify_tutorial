# NOTE: only doing this in development as some production environments (Heroku)
# NOTE: are sensitive to local FS writes, and besides -- it's just not proper
# NOTE: to have a dev-mode tool do its thing in production.
if Rails.env.development?
  RailsERD.load_tasks

  # Workaround for Rails 6
  # see https://github.com/voormedia/rails-erd/issues/322
  Rake::Task["erd:load_models"].clear
  namespace :erd do
    task :load_models do
      say "Loading application environment..."
      Rake::Task[:environment].invoke

      say "Loading code in search of Active Record models..."
      Zeitwerk::Loader.eager_load_all
    end
  end
end
