class XML
  def initialize(out)
    @out = out # Remember where to send our output
  end
  
  def content(text)
    @out << text.to_s
    nil
  end
  
  def comment(text)
    @out << "<!-- #{text} -->"
    nil
  end
  
  def tag(tagname, attributes={})
    #p caller
        @out << "<#{tagname}"
    attributes.each {|attr,value| @out << " #{attr}='#{value}'" }
    if block_given?
      @out << ">\n"
      content = yield
      if content
        @out << content.to_s
      end
      @out << "</#{tagname}>"
    else
      @out << '/>'
    end
    nil
  end
  
  def init
    yield
  end
  
  alias method_missing tag
  def self.generate(out, &block)
    XML.new(out).instance_eval &block
  end
end








XML.generate(STDOUT) do
  html do
    head do
      title { "Test Page for XML.generate" }
      comment "This is a test"
    end
    body do
      h1(:style => "font-family:sans-serif") { "Test Page for XML.generate" }
      ul :type=>"square" do
        li { Time.now }
        li { RUBY_VERSION }
      end
    end
  end
end

