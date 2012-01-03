#!/usr/bin/env ruby19 -WKU
require "front-compiler"

c = FrontCompiler.new
Dir.glob('_compiled/**/*.{html}').each do |f|
	compressed = c.compact_file(f)
	File.open(f, "w") { |file| file.write compressed }
end