require 'java'
require 'jruby/core_ext'
 
# brew install hadoop
HADOOP_ROOT = "/usr/local/Cellar/hadoop/2.2.0/libexec/"
Dir.glob( File.join( HADOOP_ROOT, "**/*.jar" ) ).each do |jar|
    require jar
end
 
# http://hadoop.apache.org/mapreduce/docs/r0.21.0/api/org/apache/hadoop/mapreduce/Mapper.html
# org.apache.hadoop.mapreduce Class Mapper<KEYIN,VALUEIN,KEYOUT,VALUEOUT>
Mapper = org.apache.hadoop.mapreduce.Mapper
 
class TestA < Mapper
  def initialize
    super
  end
end
 
puts "Ruby TestA class : #{TestA.name}"
 
puts "Test A Ancestors: #{TestA.ancestors.join(", ")}"
 
java_class = TestA.become_java!
 
if java_class.nil? then
    puts "become_java! returned nil"
      puts "TestA name = #{TestA.name}"
else
    puts java_class.interfaces.each { |i| puts i }
end

puts TestA.new.java_class