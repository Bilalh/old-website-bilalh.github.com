#!/usr/bin/env ruby19
# encoding: utf-8
require_relative 'custom_page'
require "Nokogiri"
require "Maruku"

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
			
			self.data['title']     = info['title'] || name
			self.data['version']   = info['version_title'] || info['version']
			self.data['repo']      = "https://github.com/#{site.config['github_user']}/#{name}"
			self.data['download']  = "#{self.data['repo']}/zipball/#{info['version'] || 'master'}"
			self.data['docs']      = info['docs'] == 'wiki' ? "#{self.data['repo']}/wiki" : info['docs'] if info['docs']
			
			self.data['changelog_url'] = 'changelog.html'  if info['changelog']
			
			self.data['icon']      = info['icon']      if info['icon']  
			if info['features']  then
				self.data['features']  = info['features']
				self.data['readme_url'] = 'readme.html'  if info['changelog']
				
			end
			
			readme = check_cache(name,'readme.md')
			self.data['readme'] = Maruku.new(readme).to_html
			
			doc = Nokogiri::HTML(self.data['readme'])
			self.data['description'] = info['description'] || doc.css('#description').text || ""
			
			
			if info['languages'] then
				self.data['languages'] = info['languages'].split(/, */).join(" &nbsp&nbsp")
			end 
			
		end 
	end

	# Sets the commons vars for a project page
	class ProjectPage < CustomPage
		def initialize(site, base, dir, name, project,html_name)
			@project = project
			puts "Building project's #{name}"
			super site, base, dir, name, html_name
			['title', 'version','repo','download', 'icon', 'changelog_url', 'readme_url'].each do |key|
				self.data[key] = project.data[key]
			end
			self.data['project_url'] = project.data['url']
		end
		
		def copy_keys(*keys)
			keys.each do |key|
				self.data[key] = @project.data[key] if @project.data[key]
			end
		end
		
	end
	
	class Readme < ProjectPage
		def initialize(site, base, dir, name, project)
			super site, base, dir, 'readme', project, "readme.html"
			copy_keys 'readme', 'description'
		end	
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
			
			builder = Nokogiri::XML::Builder.new do |xml|
				xml.table{
					xml << "<tr>"
					(changelog.scan(/-+\n([\w :().+]+)\n-+/m)).each_with_index do |e,i|
						xml << "</tr><tr>" if i %5 == 0
						xml.td{
							text = e.flatten[0]
							name = text.gsub(/ \(.*\)/, '')
							id   = text.gsub!(/\s/,'+')
							xml.a(:href => "##{id}"){
								xml << name
							}	
						}
					end
					xml << "</tr>"
				}
			end
			
			toc = builder.to_xml
			toc.sub!(/<\?xml version="1.0"\?>/, '')
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
				write_page ChangeLog.new(self, self.source, File.join(dir, slug),k, p) if v['changelog']
				write_page Readme.new(self, self.source, File.join(dir, slug),k, p) if v['features']
				
			end
			
			write_page Projects.new(self, self.source, dir, projects) if self.layouts.key? 'projects'
		end
	end
	
end
 