require File.dirname(__FILE__) + '/class_documentation'

module SelfDoc
  # = SelfDoc::ClassMethods
  # This module is used to extend the Class class in order to add to it the documentation method
  # and inkect the rest of the documentation behaviors through it
  module ClassMethods
    def clear_documentation!
      @self_documentation = nil if defined?(@self_documentation)
    end

    def documentation(&block)
      @self_documentation = SelfDoc::ClassDocumentation.new(self)
      block.call if block_given?
    end

    def has_documentation?
      ! defined?(@self_documentation).nil?
    end

    def class_documentation
      defined?(@self_documentation) ? @self_documentation : nil
    end

    def render_documentation(opts={:format=>:plain})
      self.class_documentation.render_documentation(opts)
    end
  end
end
