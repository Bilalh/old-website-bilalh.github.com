#!/usr/bin/env ruby19 -WKU
require "front-compiler"

class FrontCompiler::HTMLCompactor
	  def remove_trailing_spaces(source)
		source.gsub /(\n[ \t]*)+/, "\n"
		end
end

c = FrontCompiler.new
Dir.glob('_site/**/*.{html,css,js}').each do |f|
	compressed = c.compact_file(f)
	File.open(f, "w") { |file| file.write compressed }
end