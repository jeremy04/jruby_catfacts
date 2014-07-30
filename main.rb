require 'java'
require 'pp'
require "logging"
require "./cat_fact"

java_import "CatJob"


Dir["#{File.expand_path File.dirname(__FILE__)}/jars/*.jar"].each { |jar| require jar }

class Foo
  include Logging
  
  def initialize(name)
    @name = name
  end

  def set_frequency(frequency)
    @frequency = frequency
  end

  def report
  logger.warn "Reporting in"
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

cat_fact = CatFact.new

scheduler = factory.getScheduler
job = CatJob

cat_fact = CatFact.new
users = cat_fact.users.select { |user| user["status"] == "active" }

users.each do |user|
  cron_schedule = org.quartz.CronScheduleBuilder.cronSchedule(org.quartz.CronExpression.new( CronSchedule.new.every(user['freq']) ))
  job_detail = org.quartz.JobBuilder.newJob(job.java_class).withIdentity(user['name'], "group1").usingJobData("email", user['email']).build
  trigger = org.quartz.TriggerBuilder.newTrigger.withIdentity("trigger_#{user['name']}", "group1").withSchedule(cron_schedule).build
  scheduler.scheduleJob(job_detail, trigger)
end

scheduler.start
