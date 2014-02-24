require 'java'
require 'pp'
require 'jruby/core_ext'

Dir["#{File.expand_path File.dirname(__FILE__)}/jars/*.jar"].each { |jar| require jar }

java_import "HelloJob"

# Run like:

# jruby --2.0 -S main.rb -Dlog4j.configuration=log4j2.xml

# or add it to the class path

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


Foo.new

class HelloJob < org.quartz.Job
  def initialize
    super
  end

  def execute context
    puts "Hello World"
  end
end

factory = org.quartz.impl.StdSchedulerFactory.new
scheduler = factory.getScheduler

cron_schedule = org.quartz.CronScheduleBuilder.cronSchedule("0/20 * * * * ?")

job_detail = org.quartz.JobBuilder.newJob(HelloJob.become_java!).withIdentity("job1", "group1").build

trigger = org.quartz.TriggerBuilder.newTrigger.withIdentity("trigger", "group1").withSchedule(cron_schedule).build

scheduler.scheduleJob(job_detail, trigger);

scheduler.start
