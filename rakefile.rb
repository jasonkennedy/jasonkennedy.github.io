require 'listen'

COMPASS_PATH = "content"
SASS_PATH = "content/sass"
CSS_FILE_PATH = "content/css/all.css"
KSS_TEMPLATE_PATH = "styleguide-template/"

task :default => ['kss:styleguide']

namespace :kss do
	task :init => ['bundler:update'] do 
		system "npm install kss"
		Rake::Task['kss:styleguide'].invoke()
	end
	
	task :styleguide => ['sass:compile'] do 
		system "kss-node #{SASS_PATH}  --template #{KSS_TEMPLATE_PATH} --style #{CSS_FILE_PATH}"
	end
	
	task :watch do
		puts "Listening for changes to files in #{SASS_PATH}..."
		callback = Proc.new do |modified, added, removed|
			puts "Changes detected!"
			puts "Modified: #{modified}"
			puts "Added: #{added}"
			puts "Removed: #{removed}"
			puts "Running kss styleguide generation"
			system "kss-node #{SASS_PATH}  --template #{KSS_TEMPLATE_PATH} --style #{CSS_FILE_PATH}"
		end
		listener = Listen.to(SASS_PATH, :force_polling => true, &callback)
		listener.start # not blocking
		sleep
	end
end

namespace :sass do
	task :compile do
		system "compass compile #{COMPASS_PATH} -e production --force --css-dir=css"
	end
end

namespace :bundler do
	task :update do
		system "bundle update"
	end
end