# Edit classpath for JRuby class loader
# export CLASSPATH=$CLASSPATH:./jars/*

# Compile HelloJob.rb into Java code:
# jrubyc --javac -c ./jars/quartz-2.2.1.jar:$JRUBY_JAR_DIR:. hello_job.rb

require 'java'
java_import "org.quartz.Job"
java_import 'org.quartz.JobExecutionException'

class HelloJob
  java_implements Java::OrgQuartz::Job

  java_signature "public void execute(org.quartz.JobExecutionContext jobExecutionContext) throws JobExecutionException"
  def execute context
    puts "WOO"
  end
end