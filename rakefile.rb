COMPASS_PATH = "content"
SASS_PATH = "content/sass"
CSS_PATH = "content/css/all.css"
KSS_TEMPLATE_PATH = "styleguide-template/"
COMMIT_MSG = "Styleguide regenerated"

task :default => ['kss:styleguidequick']

namespace :kss do
	STDOUT.sync = true
	task :styleguide => ['bundler:update', 'sass:compile'] do 
		commit = get_commit_hash_and_date
		puts commit
		puts COMMIT_MSG
		if commit != COMMIT_MSG
			system "npm install kss"
			Rake::Task['kss:styleguidequick'].invoke()
			system "git add -A"
			system "git commit -am \"#{COMMIT_MSG}\""
			system "git push origin master"
		end
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

def get_commit_hash_and_date
	begin
		commit = `git log -1 --pretty=format:%s`
	rescue
		commit = "git unavailable"
	end
	commit
end