require 'rake'
require 'rake/gempackagetask'
require 'rake/clean'
require 'rake/testtask'
require 'rake/rdoctask'
require 'find'
require 'rubygems'
require 'rubygems/gem_runner'
gem 'rubyforge','1.0.3'
require 'rubyforge'
gem 'rspec','1.2.9'
require 'spec'
require 'spec/rake/spectask'

@gem_spec = Gem::Specification.new do |s|
  s.name = "uunique_ids"
  s.version = "0.1"
  s.summary = "uunique_ids - Lightweight wrapper for standard UUID tools"
  s.description = "uunique_ids was developed by: Tracy Flynn"
  s.author = "Tracy Flynn"
  s.email = "gems@olioinfo.net"
  s.homepage = "http://www.olioinfo.net/projects"
  s.files = FileList['lib/**/*.*', 'README', 'doc/**/*.*', 'bin/**/*.*']
  s.require_paths = ['lib']
  s.extra_rdoc_files = ["README"]
  s.has_rdoc = true
  s.rubyforge_project = "uunique_ids"
  s.add_dependency("ez_chaff", "0.2")
  s.add_dependency("uuidtools", "2.1.1")
  
  # s.test_files = FileList['spec/**/*']
  #s.bindir = "bin"
  #s.executables << "uunique_ids"
  #s.add_dependency("", "")
  #s.add_dependency("", "")
  #s.extensions << ""
  #s.required_ruby_version = ">= 1.8.6"
  #s.default_executable = ""
  #s.platform = "Gem::Platform::Ruby"
  #s.requirements << "An ice cold beer."
  #s.requirements << "Some free time!"
end

# rake package
Rake::GemPackageTask.new(@gem_spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = false
  rm_f FileList['pkg/**/*.*']
end

# rake
desc 'Run specifications'
Spec::Rake::SpecTask.new(:default) do |t|
  opts = File.join(File.dirname(__FILE__), "spec", 'spec.opts')
  t.spec_opts << '--options' << opts if File.exists?(opts)
  t.spec_files = Dir.glob('spec/**/*_spec.rb')
end

desc 'regenerate the gemspec'
task :gemspec do
  @gem_spec.version = "#{@gem_spec.version}.#{Time.now.strftime('%Y%m%d%H%M%S')}"
  File.open(File.join(File.dirname(__FILE__), 'uunique_ids.gemspec'), 'w') {|f| f.puts @gem_spec.to_ruby}
end

desc "Install the gem"
task :install => [:package] do |t|
  sudo = ENV['SUDOLESS'] == 'true' || RUBY_PLATFORM =~ /win32|cygwin/ ? '' : 'sudo'
  puts `#{sudo} gem install #{File.join("pkg", @gem_spec.name)}-#{@gem_spec.version}.gem --no-update-sources --no-ri --no-rdoc`
end

desc "Release the gem"
task :release => :install do |t|
  begin
    ac_path = File.join(ENV["HOME"], ".rubyforge", "auto-config.yml")
    if File.exists?(ac_path)
      fixed = File.open(ac_path).read.gsub("  ~: {}\n\n", '')
      fixed.gsub!(/    !ruby\/object:Gem::Version \? \n.+\n.+\n\n/, '')
      puts "Fixing #{ac_path}..."
      File.open(ac_path, "w") {|f| f.puts fixed}
    end
    begin
      rf = RubyForge.new
      rf.configure
      rf.login
      rf.add_release(@gem_spec.rubyforge_project, @gem_spec.name, @gem_spec.version, File.join("pkg", "#{@gem_spec.name}-#{@gem_spec.version}.gem"))
    rescue Exception => e
      if e.message.match("Invalid package_id") || e.message.match("no <package_id> configured for")
        puts "You need to create the package!"
        rf.create_package(@gem_spec.rubyforge_project, @gem_spec.name)
        rf.add_release(@gem_spec.rubyforge_project, @gem_spec.name, @gem_spec.version, File.join("pkg", "#{@gem_spec.name}-#{@gem_spec.version}.gem"))
      else
        raise e
      end
    end
  rescue Exception => e
    if e.message == "You have already released this version."
      puts e
    else
      raise e
    end
  end
end


Rake::RDocTask.new do |rd|
  rd.main = "README"
  files = Dir.glob("**/*.rb")
  files = files.collect {|f| f unless f.match("test/") || f.match("doc/") }.compact
  files << "README"
  rd.rdoc_files = files
  rd.rdoc_dir = "doc"
  rd.options << "--line-numbers"
  rd.options << "--inline-source"
  rd.title = "uunique_ids"
end

# require 'rubygems'
# gem 'gemstub','1.5.7'
# require 'gemstub'
# 
# Gemstub.test_framework = :rspec
# 
# Gemstub.gem_spec do |s|
#   s.name = "uunique_ids"
#   s.version = "0.1"
#   s.summary = "uunique_ids - Lightweight wrapper for standard UUID tools"
#   s.description = "uunique_ids was developed by: Tracy Flynn"
#   s.author = "Tracy Flynn"
#   s.email = "gems@olioinfo.net"
#   s.homepage = "http://www.olioinfo.net/projects"
#   s.files = FileList['lib/**/*.*', 'README', 'doc/**/*.*', 'bin/**/*.*']
#   s.require_paths = ['lib']
#   s.extra_rdoc_files = ["README"]
#   s.has_rdoc = true
#   s.rubyforge_project = "uunique_ids"
#   s.add_dependency("ez_chaff", "0.2")
#   s.add_dependency("uuidtools", "2.1.1")
# end
# 
# # Gemstub.rdoc do |rd|
# #   rd.title = "fake_gem"
# # end
