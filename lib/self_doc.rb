$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require File.dirname(__FILE__)+"/self_doc/class_methods"

module SelfDoc
  VERSION = '0.0.1'
end

class Class
  include SelfDoc::ClassMethods
end
