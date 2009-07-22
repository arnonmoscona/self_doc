module SelfDoc
  # This class is the main documentation context for the self_doc gem.
  # The block passed to the documentation method executes in the context of an instance of this class.
  # Therefore, most of the methods that are defined in the readme are actually implemented in this class.
  class ClassDocumentation
    def initialize(clazz)
      @for_class = clazz
    end

    attr_reader :for_class

    def render_documentation(opts)
      renderer_source_file_name = "#{opts[:format]}_renderer"
      begin
        require renderer_source_file_name
      rescue LoadError
        require File.dirname(__FILE__) + "/" + renderer_source_file_name
      end

      # the following fancy footwork is all about trying to load a pluggable renderer without
      # creating a dependency on active support
      class_short_name = renderer_source_file_name.split("_").collect{|str|str.capitalize}.join("")
      class_full_name = "SelfDoc::"+ class_short_name

      if ! SelfDoc.const_defined?(class_short_name.to_sym)
        raise ArgumentError.new("Could not find class #{class_full_name}")
      end

      renderer_class = SelfDoc.const_get(class_short_name.to_sym)
      renderer = renderer_class.new(self)
      renderer.render
    end
  end
end