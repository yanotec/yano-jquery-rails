require "bundler/gem_tasks"
task :default => :spec

require 'bundler'
require 'rake/testtask'
Bundler::GemHelper.install_tasks

task default: :test

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/*_test.rb'
  t.warning = true
  t.verbose = true
end

# Check if versions are correct between VERSION constants and .js files
#
task :release => [:guard_version]

task :guard_version do
  def check_version(file, pattern, constant)
    body = File.read("vendor/assets/javascripts/#{file}")
    match = body.match(pattern) or abort "Version check failed: no pattern matched in #{file}"
    file_version = match[1]
    constant_version = Jquery::Rails.const_get(constant)

    unless constant_version == file_version
      abort "Jquery::Rails::#{constant} was #{constant_version} but it should be #{file_version}"
    end
  end

  check_version('jquery.js', /jQuery JavaScript Library v([\S]+)/, 'JQUERY_VERSION')
  check_version('jquery2.js', /jQuery JavaScript Library v([\S]+)/, 'JQUERY_2_VERSION')
end

desc "Update jQuery versions"
task :update_jquery do
  def download_jquery(filename, version)
    suffix = "-#{version}"

    puts "Downloading #{filename}.js"
    puts `curl -o vendor/assets/javascripts/jquery/#{filename}.js http://code.jquery.com/jquery#{suffix}.js`
    puts "Downloading #{filename}.min.js"
    puts `curl -o vendor/assets/javascripts/jquery/#{filename}.min.js http://code.jquery.com/jquery#{suffix}.min.js`
    puts "Downloading #{filename}.min.map"
    puts `curl -o vendor/assets/javascripts/jquery/#{filename}.min.map http://code.jquery.com/jquery#{suffix}.min.map`
  end

  download_jquery('jquery', Yano::Jquery::Rails::JQUERY_VERSION)
  download_jquery('jquery2', Yano::Jquery::Rails::JQUERY_2_VERSION)
  puts "\e[32mDone!\e[0m"
end

desc "Update jQuery UI versions"
task :update_jquery_ui do

  JS_COMPONENTS.each do |name, component|
    puts "Downloading jquery-ui/#{name}.js"
    puts `curl -o vendor/assets/javascripts/jquery/ui/#{name}.js https://raw.githubusercontent.com/jquery/jquery-ui/#{Yano::Jquery::Rails::JQUERY_UI_VERSION}/ui/#{component}.js`
  end

  puts "echo '/*' > vendor/assets/javascripts/jquery/jquery-ui.js"
  JS_COMPONENTS.each do |name, _|
    puts "echo ' * require ./ui/#{name}' >> vendor/assets/javascripts/jquery/jquery-ui.js"
  end

  puts "echo ' */' >> vendor/assets/javascripts/jquery/jquery-ui.js"

  puts "Downloading jquery-ui.min.js"
  puts `curl -o vendor/assets/javascripts/jquery/jquery-ui.min.js http://code.jquery.com/jquery#{Yano::Jquery::Rails::JQUERY_UI_VERSION}.min.js`


  CSS_COMPONENTS.each do |component|
    puts "Downloading jquery-ui/#{component}.css"
    puts `curl -o vendor/assets/stylesheets/jquery/ui/#{component}.css https://raw.githubusercontent.com/jquery/jquery-ui/#{Yano::Jquery::Rails::JQUERY_UI_VERSION}/themes/base/#{component}.css`
  end

  puts "\e[32mDone!\e[0m"
end

desc "Update jQuery UJS version"
task :update_jquery_ujs do
  puts "Downloading jquery_ujs.js"
  puts `curl -o vendor/assets/javascripts/jquery/jquery_ujs.js https://raw.githubusercontent.com/rails/jquery-ujs/v#{Yano::Jquery::Rails::JQUERY_UJS_VERSION}/src/rails.js`
  puts "\e[32mDone!\e[0m"
end
