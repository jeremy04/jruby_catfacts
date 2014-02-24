require 'java'
Dir["#{File.expand_path File.dirname(__FILE__)}/jars/*.jar"].each { |jar| require jar; $CLASSPATH << "./jars/#{jar}" }


class HelloJob
  java_implements org.quartz.Job
  #include org.quartz.Job

  java_signature "void execute(org.quartz.JobExecutionContext)"
  def execute context
    puts "WOO"
  end

  #add_method_signature :execute, [org.quartz.JobExecutionContext]
end