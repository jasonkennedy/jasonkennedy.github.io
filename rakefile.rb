COMPASS_PATH = "content"
SASS_PATH = "content/sass"
CSS_PATH = "content/css/all.css"
KSS_TEMPLATE_PATH = "styleguide-template/"
COMMIT_MSG = "Updates styleguide"

task :default => ['kss:styleguidequick']

namespace :kss do
	task :styleguide => ['bundler:update', 'sass:compile'] do 
		commit_data = get_commit_hash_and_date
		if commit_data[0] != COMMIT_MSG
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
		commit = `git log -1 --pretty=format:%H`
		git_date = `git log -1 --date=iso --pretty=format:%ad`
		commit_date = DateTime.parse( git_date ).strftime("%Y-%m-%d %H%M%S")
	rescue
		commit = "git unavailable"
	end

	[commit, commit_date]
end