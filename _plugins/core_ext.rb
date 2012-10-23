#!/usr/bin/env ruby
class String
  def slugize
    self.downcase.gsub(/[\s\.]/, '-').gsub(/[^\w\d\-]/, '').downcase
  end
end
 