

import org.jruby.Ruby;
import org.jruby.RubyObject;
import org.jruby.runtime.Helpers;
import org.jruby.runtime.builtin.IRubyObject;
import org.jruby.javasupport.JavaUtil;
import org.jruby.RubyClass;
import org.quartz.Job;
import org.quartz.JobExecutionException;


public class CatJob extends RubyObject implements Job {
    private static final Ruby __ruby__ = Ruby.getGlobalRuntime();
    private static final RubyClass __metaclass__;

    static {
        String source = new StringBuilder("# Edit classpath for JRuby class loader\n" +
            "# export CLASSPATH=$CLASSPATH:./jars/*\n" +
            "\n" +
            "# Compile CatJob.rb into Java code:\n" +
            "# jrubyc --javac -c ./jars/quartz-2.2.1.jar:$JRUBY_JAR_DIR:. cat_job.rb\n" +
            "\n" +
            "require 'java'\n" +
            "java_import \"org.quartz.Job\"\n" +
            "java_import 'org.quartz.JobExecutionException'\n" +
            "\n" +
            "require \"./cat_fact\"\n" +
            "require \"./send_cat_fact\"\n" +
            "\n" +
            "class CatJob\n" +
            "  java_implements Java::OrgQuartz::Job\n" +
            "\n" +
            "  java_signature \"public void execute(org.quartz.JobExecutionContext jobExecutionContext) throws JobExecutionException\"\n" +
            "  def execute context\n" +
            "    cat_fact = CatFact.new\n" +
            "    cat_fact.download_facts!\n" +
            "    fact = cat_fact.random_fact\n" +
            "    puts \"Sending cat fact #{context.getFireTime} #{fact}\"\n" +
            "    email = context.getJobDetail.getJobDataMap.getString(\"email\")\n" +
            "    SendCatFact.send_email(email, fact)\n" +
            "  end\n" +
            "end").toString();
        __ruby__.executeScript(source, "cat_job.rb");
        RubyClass metaclass = __ruby__.getClass("CatJob");
        if (metaclass == null) throw new NoClassDefFoundError("Could not load Ruby class: CatJob");
        metaclass.setRubyStaticAllocator(CatJob.class);
        __metaclass__ = metaclass;
    }

    /**
     * Standard Ruby object constructor, for construction-from-Ruby purposes.
     * Generally not for user consumption.
     *
     * @param ruby The JRuby instance this object will belong to
     * @param metaclass The RubyClass representing the Ruby class of this object
     */
    private CatJob(Ruby ruby, RubyClass metaclass) {
        super(ruby, metaclass);
    }

    /**
     * A static method used by JRuby for allocating instances of this object
     * from Ruby. Generally not for user comsumption.
     *
     * @param ruby The JRuby instance this object will belong to
     * @param metaclass The RubyClass representing the Ruby class of this object
     */
    public static IRubyObject __allocate__(Ruby ruby, RubyClass metaClass) {
        return new CatJob(ruby, metaClass);
    }

    /**
     * Default constructor. Invokes this(Ruby, RubyClass) with the classloader-static
     * Ruby and RubyClass instances assocated with this class, and then invokes the
     * no-argument 'initialize' method in Ruby.
     */
    public CatJob() {
        this(__ruby__, __metaclass__);
        Helpers.invoke(__ruby__.getCurrentContext(), this, "initialize");
    }

    
    public void execute(org.quartz.JobExecutionContext jobExecutionContext) throws JobExecutionException {
        IRubyObject ruby_arg_jobExecutionContext = JavaUtil.convertJavaToRuby(__ruby__, jobExecutionContext);
        IRubyObject ruby_result = Helpers.invoke(__ruby__.getCurrentContext(), this, "execute", ruby_arg_jobExecutionContext);
        return;

    }

}
