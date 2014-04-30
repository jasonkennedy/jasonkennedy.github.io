require 'listen'

ROOT = "content"
SASS_PATH = "#{ROOT}/sass"
CSS_FILE_PATH = "#{ROOT}/css/all.css"
KSS_TEMPLATE_PATH = "styleguide-template/"
KSS_COMMAND = "kss-node #{SASS_PATH}  --template #{KSS_TEMPLATE_PATH} --style #{CSS_FILE_PATH}"
SASS_COMMAND = "compass compile #{ROOT} -e production --force --css-dir=css"

task :default => ['kss:styleguide']

namespace :kss do
	task :init => ['bundler:update'] do 
		system "npm install kss"
		Rake::Task['kss:styleguide'].invoke()
	end
	
	task :styleguide => ['sass:compile'] do 
		system "#{KSS_COMMAND}"
	end
	
	task :watch do
		puts "Listening for changes to files in #{SASS_PATH}..."
		callback = Proc.new do |modified, added, removed|
			puts "Changes detected!"
			puts "Modified: #{modified}"
			puts "Added: #{added}"
			puts "Removed: #{removed}"
			puts "Recompiling sass"
			system "#{SASS_COMMAND}"
			puts "Running kss styleguide generation"
			system "#{KSS_COMMAND}"
		end
		listener = Listen.to(SASS_PATH, :force_polling => true, &callback)
		listener.start # not blocking
		sleep
	end
end

namespace :sass do
	task :compile do
		system "#{SASS_COMMAND}"
	end
end

namespace :bundler do
	task :update do
		system "bundle update"
	end
end