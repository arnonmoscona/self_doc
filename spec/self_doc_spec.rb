require File.dirname(__FILE__) + '/spec_helper.rb'

# Time to add your specs!
# http://rspec.info/

module SelfDocSpec
  class MyClass
    
  end

  class NoDoc

  end
end

describe "self_doc" do

  describe "Class instrumentation" do
    before :each do
      SelfDocSpec::MyClass.clear_documentation!
    end

    it "should add the documentation method to the Class object" do
      lambda{ SelfDocSpec::MyClass.documentation }.should_not raise_error
    end

    specify "should define a documentation method that takes a block and executes it" do
      SelfDocSpec::MyClass.documentation{"some docs"}.should == "some docs"
    end

    specify "should have a test for documentation presence that returns false when the documentation method has never been called" do
      SelfDocSpec::NoDoc.has_documentation?.should be_false
    end
    
    specify "should produce a documentation object whose presence can be tested with the has_documentation? method method" do
      SelfDocSpec::MyClass.documentation {"bla"}
      SelfDocSpec::MyClass.has_documentation?.should be_true
    end

    it "should create a class_documentation object when documentation is called" do
      SelfDocSpec::MyClass.class_documentation.should be_nil
      SelfDocSpec::MyClass.documentation {"bla"}
      SelfDocSpec::MyClass.class_documentation.should_not be_nil
    end

    it "should associate the class with the embeded class documentation" do
      SelfDocSpec::MyClass.documentation {"bla"}
      SelfDocSpec::MyClass.class_documentation.for_class.should == SelfDocSpec::MyClass
    end
  end

  describe "documentation" do
    describe "pluggable renderers" do
      it "should have a test renderer" do
        SelfDocSpec::MyClass.render_documentation(:format=>:test).class.should == String
      end

      it "should have a plain text renderer" do
        SelfDocSpec::MyClass.render_documentation(:format=>:plain).class.should == String
      end

      it "should have a default renderer" do
        SelfDocSpec::MyClass.render_documentation.class.should == String
      end

      it "should raise an an error if you try to render in an unknown format" do
        lambda{SelfDocSpec::MyClass.render_documentation(:format=>:no_renderer_for_this)}.should raise_error
      end
    end
  end

end
