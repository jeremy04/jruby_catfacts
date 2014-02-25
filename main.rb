require 'java'
require 'pp'
java_import "HelloJob"

Dir["#{File.expand_path File.dirname(__FILE__)}/jars/*.jar"].each { |jar| require jar }


# Edit classpath for JRuby class loader
# export CLASSPATH=$CLASSPATH:./jars/*

# Run like so:
# jruby --2.0 -S main.rb -Dlog4j.configuration=log4j2.xml

$CLASSPATH << "#{File.dirname(__FILE__)}/log4j2.xml"

module Logging

  def logger
    org.apache.logging.log4j.LogManager.getLogger self.class.to_s
  end

end

class Foo
  include Logging
  
  def initialize(name)
    @name = name
  end

  def set_frequency(frequency)
    @frequency = frequency
  end

  def report
    "#{@name} is #{@frequency}"
  end

end

factory = org.quartz.impl.StdSchedulerFactory.new
scheduler = factory.getScheduler

cron_schedule = org.quartz.CronScheduleBuilder.cronSchedule("0/20 * * * * ?")
job_detail = org.quartz.JobBuilder.newJob(HelloJob.java_class).withIdentity("job1", "group1").build
trigger = org.quartz.TriggerBuilder.newTrigger.withIdentity("trigger", "group1").withSchedule(cron_schedule).build
scheduler.scheduleJob(job_detail, trigger);
scheduler.start
