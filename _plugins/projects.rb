#!/usr/bin/env ruby19
# encoding: utf-8
require_relative 'custom_page'

module Jekyll
	
	class Projects < CustomPage
		def initialize(site, base, dir, projects)
			super site, base, dir, 'projects'
			data = []
			projects.each { |v| data << v.data }
			self.data['projects'] = data
		end
	end
	
	class Project < CustomPage
		def initialize(site, base, dir, name, info)
			super site, base, dir, 'project'
			puts "Building project: #{name}"
			
			self.data['title']			 = info['title'] || name
			self.data['version']		 = info['version_title'] || info['version']
			self.data['repo']				 = "https://github.com/#{site.config['github_user']}/#{name}"
			self.data['download']		 = "#{self.data['repo']}/zipball/#{info['version'] || 'master'}"
			self.data['docs']				 = info['docs'] == 'wiki' ? "#{self.data['repo']}/wiki" : info['docs'] if info['docs']
			self.data['description'] = info['description']
			
			readme = check_cache(name,'readme.md')
			
			self.data['readme']		 =	readme
			self.data['changelog'] = 'changelog.html'
		end 
	end

	# Sets the commons vars for a project page
	class ProjectPage < CustomPage
		def initialize(site, base, dir, name, project,html_name)
			puts "Building project's #{name}"
			super site, base, dir, name, html_name
			['title', 'version','repo','download'].each do |key|
				self.data[key] = project.data[key]
			end
			self.data['project_url'] = project.data['url']
		end 
		#[Version 1.2](#Version+1.2+(Thu+Aug+11+2011+03:34:20++0100\))
	end
	
	class ChangeLog < ProjectPage
		def initialize(site, base, dir, name, project)
			super site, base, dir, 'changelog', project, "changelog.html"
			filename="/Users/bilalh/Desktop/Changelog.md"
			
			changelog = IO.read filename
			changelog.gsub!(/\`{3} ?(\w+)\n(.+?)\n\`{3}/m, "{% highlight \\1 %}\n\\2\n{% endhighlight %}")
			changelog = Liquid::Template.parse(changelog).render(
				{}, :filters => [Jekyll::Filters], :registers => { :site => site }
			)
			
			toc = ""
			changelog.scan(/-+\n([\w :().+]+)\n-+/m).each do |e|
				text= e.flatten[0]
				name = text.gsub(/ \(.*\)/, '')
				id = text.gsub(/ (.*)\)/, '\1\\)')
				id.gsub!(/\s/,'+')
				toc << "[#{name}](##{id})\n"
			end
			changelog.sub! /([\w :().+]+\n=+)/m, "#ChangeLog\n#{toc}"
			
			self.data['changelog'] = changelog
			
		end
		
	end
	
	class Site
		def generate_projects
			return unless self.config.key? 'projects'
			throw "No 'project' layout found." unless self.layouts.key? 'project'
			dir = self.config['project_dir'] || 'projects'
			projects = []
			Dir.mkdir '_cache' unless	 File.directory?('_cache')
			
			self.config['projects'].each do |k, v|
				slug = v['slug'] || k.slugize
				p = Project.new(self, self.source, File.join(dir, slug), k, v)
				p.data['url'] = "/#{dir}/#{slug}"
				projects << p
				write_page p
				write_page ChangeLog.new(self, self.source, File.join(dir, slug),k, p)
			end
			
			write_page Projects.new(self, self.source, dir, projects) if self.layouts.key? 'projects'
		end
	end
	
end
 