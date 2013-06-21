$: << File.expand_path('../../app', __FILE__)
ENV["RAILS_ENV"] ||= 'test'

require 'active_record'
unless ActiveRecord::Base.connected?
  ActiveRecord::Base.establish_connection YAML.load_file(File.expand_path('../../config/database.yml', __FILE__))['test']
end

# validators
Dir[File.expand_path('../../app/validators/*', __FILE__)].each {|file| require file }

