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
		def initialize(site, base, dir, name, info, url)
			super site, base, dir, 'project'
			puts "Building project: #{name}"
			
			self.data['name']      = name
			self.data['title']     = info['title'] || name
			self.data['version']   = info['version_title'] || info['version']
			self.data['repo']      = "https://github.com/#{site.config['github_user']}/#{name}"
			self.data['download']  = info['download'] || "#{self.data['repo']}/zipball/#{info['version'] || 'master'}"
			self.data['docs']      = info['docs'] == 'wiki' ? "#{self.data['repo']}/wiki" : info['docs'] if info['docs']
			
			self.data['changelog_url'] = 'changelog.html'  if info['changelog']
			self.data['apidocs_url']   = "/docs/#{name}"   if info['apidocs']
			self.data['support_url']   = info['support']   if info['support']
			self.data['icon']          = info['icon']      if info['icon']  
			
			if info['gallery'] then 
				self.data['gallery_url']  = 'gallery.html'    
				self.data['gallery']      = info['gallery']
			end
			
			self.data['apidocs_name']  = info['apidocs_name']   if info['apidocs_name']
			
			if info['features']  then
				self.data['features']     = info['features']
				self.data['readme_url']   = 'readme.html'
				self.data['features_url'] = url
			elsif self.data['changelog_url'] #TODO else?
				self.data['readme_url']   = url
			end
			
			readme =
			if info['readme'] then
				IO.read info['readme']
			else
				check_cache(name,"Readme.md")
			end
			self.data['readme'] = Maruku.new(readme).to_html
			self.data['readme_name'] = info['readme_name'] if info['readme_name']
			
			doc = Nokogiri::HTML(self.data['readme'])
			self.data['description'] = info['description'] || doc.css('#description').text || ""
			
			self.data['changelog_location'] =     info['changelog_location']     || nil
			self.data['changelog_heading_hash'] = info['changelog_heading_hash'] || false
			
			if info['languages'] then
				self.data['languages'] = info['languages'].split(/, */).join(" &nbsp;&nbsp;")
			end 
			
			self.data['iusethis'] = info['iusethis'] if info['iusethis']
			self.data['macupdate'] = info['macupdate'] if info['macupdate']
			
		end 
	end

	# Sets the commons vars for a project page
	class ProjectPage < CustomPage
		def initialize(site, base, dir, name, project,html_name)
			@project = project
			puts "Building project's #{name}"
			super site, base, dir, name, html_name
			['version','repo','download', 'icon', 'name'].each do |key|
				self.data[key] = project.data[key]
			end
			self.data['title'] = project.data['title'] + "'s #{name}"
			
			copy_keys 'features_url', 'apidocs_url', 'gallery_url', 
			'readme_name','changelog_url', 'readme_url', 'apidocs_name', "support_url", "iusethis", "macupdate"
		end
		
		def copy_keys(*keys)
			keys.each do |key|
				self.data[key] = @project.data[key] if @project.data[key]
			end
		end
		
	end
	
	class Gallery < ProjectPage
		def initialize(site, base, dir, name, project)
			super site, base, dir, 'gallery', project, "gallery.html"
				copy_keys 'gallery'
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
			
			changelog = check_cache(name,"Changelog.md",  project.data['changelog_location'])
			changelog.gsub!(/\`{3} ?(\w+)\n(.+?)\n\`{3}/m, "{% highlight \\1 %}\n\\2\n{% endhighlight %}")
			changelog = Liquid::Template.parse(changelog).render(
				{}, :filters => [Jekyll::Filters], :registers => { :site => site }
			)
			
			# if true check heading with  ## Heading ##
			regex = project.data['changelog_heading_hash'] ? /##\s+([\w.(): ]+)\s+##/m
																									   : /\n([\w :().+]+)\n-+/m
			
			builder = Nokogiri::XML::Builder.new do |xml|
				xml.table{
					xml << "<tr>"
					# (changelog.scan(/##\s+([\w.() ]+)\s+##/m)).each_with_index do |e,i|
					(changelog.scan(regex)).each_with_index do |e,i|
						xml << "</tr><tr>" if i %5 == 0
						xml.td{
							text = e.flatten[0]
							name = text.gsub(/ \(.*\)/, '')
							id	 = text.strip.gsub(/\s/,'_')
							id.gsub!(/[:+.()]/,'')
							id.downcase!
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
				p = Project.new(self, self.source, File.join(dir, slug), k, v,"/#{dir}/#{slug}")
				p.data['url'] = "/#{dir}/#{slug}"
				projects << p
				write_page p
				write_page ChangeLog.new(self, self.source, File.join(dir, slug),k, p) if v['changelog']
				write_page Readme.new(self, self.source, File.join(dir, slug),k, p)    if v['features']
				write_page Gallery.new(self, self.source, File.join(dir, slug),k, p)   if v['gallery']
				
			end
			
			write_page Projects.new(self, self.source, dir, projects) if self.layouts.key? 'projects'
		end
	end
	
end
 