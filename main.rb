require 'java'
require 'pp'
require "whenever"
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


class CronSchedule

  def every(duration)

    length, unit = duration.split(".")
    if unit =~ /minute/
      "0 0/#{length} * 1/1 * ? *"
    elsif unit =~ /hour/
      "0 0 0/#{length} 1/1 * ? *"
    elsif unit =~ /day/
      "0 0 #{Time.now.hour} 1/#{length} * ? *"
    end
  end
end

factory = org.quartz.impl.StdSchedulerFactory.new
scheduler = factory.getScheduler
job = HelloJob

[ { name: 'A', cron: CronSchedule.new.every("2.minutes") } , 
  { name: 'B', cron: CronSchedule.new.every("1.minutes") }].each do |user|
  cron_schedule = org.quartz.CronScheduleBuilder.cronSchedule(org.quartz.CronExpression.new(user[:cron]))
  job_detail = org.quartz.JobBuilder.newJob(job.java_class).withIdentity(user[:name], "group1").build
  trigger = org.quartz.TriggerBuilder.newTrigger.withIdentity("trigger_#{user[:name]}", "group1").withSchedule(cron_schedule).build
  scheduler.scheduleJob(job_detail, trigger)
end

scheduler.start
