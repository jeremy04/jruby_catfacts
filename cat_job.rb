# Edit classpath for JRuby class loader
# export CLASSPATH=$CLASSPATH:./jars/*

# Compile CatJob.rb into Java code:
# jrubyc --javac -c ./jars/quartz-2.2.1.jar:$JRUBY_JAR_DIR:. cat_job.rb

require 'java'
java_import "org.quartz.Job"
java_import 'org.quartz.JobExecutionException'

require "./cat_fact"
require "./send_cat_fact"

class CatJob
  java_implements Java::OrgQuartz::Job

  java_signature "public void execute(org.quartz.JobExecutionContext jobExecutionContext) throws JobExecutionException"
  def execute context
    cat_fact = CatFact.new
    cat_fact.download_facts!
    fact = cat_fact.random_fact
    puts "Sending cat fact #{context.getFireTime} #{fact}"
    email = context.getJobDetail.getJobDataMap.getString("email")
    SendCatFact.send_email(email, fact)
  end
end