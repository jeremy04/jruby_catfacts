# Edit classpath for JRuby class loader
# export CLASSPATH=$CLASSPATH:./jars/*

# Compile HelloJob.rb into Java code:
# jrubyc --javac -c ./jars/quartz-2.2.1.jar:$JRUBY_JAR_DIR:. hello_job.rb

require 'java'
java_import "org.quartz.Job"
java_import 'org.quartz.JobExecutionException'

class SupJob
  include Java::OrgQuartz::Job

  def execute context
    puts "Sup"
  end
end