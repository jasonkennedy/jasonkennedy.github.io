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