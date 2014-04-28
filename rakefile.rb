COMPASS_PATH = "content"
SASS_PATH = "content/sass"
CSS_PATH = "content/css/all.css"
KSS_TEMPLATE_PATH = "styleguide-template/"

task :default => ['kss:styleguidequick']

namespace :kss do
	task :styleguide => ['bundler:update', 'sass:compile'] do 
		system "npm install kss"
		Rake::Task['kss:styleguidequick'].invoke()
		system "git add -A"
		system "git commit -am \"Updates styleguide\""
		
	end
	
	task :styleguidequick do 
		system "kss-node #{SASS_PATH}  --template #{KSS_TEMPLATE_PATH} --style #{CSS_PATH}"
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