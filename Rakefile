require "bundler/gem_tasks"
task :default => :spec

# path to your application root.
GEM_ROOT = Pathname.new File.expand_path('../',  __FILE__)
ASSETS_PATH = Pathname.new File.expand_path('vendor/assets/',  GEM_ROOT)

desc "Update all assets"
task :update do
  Dir.chdir ASSETS_PATH do
    puts "Cleaning temp folder"
    ["rm -rf ", "mkdir -p "].each do |cmd|
      puts "#{cmd} ./tmp ./stylesheets/jquery ./javascripts/jquery ./images/jquery"
      puts `#{cmd} ./tmp ./stylesheets/jquery ./javascripts/jquery ./images/jquery`
    end

    puts "rm -f ./source_maps/*.map"
    puts `rm -f ./source_maps/*.map`
  end

  %w(update:jquery update:jquery_ui update:jquery_ujs).each do |taskename|
    Rake::Task[taskename].invoke
  end
end

namespace :update do
  desc "Update jquery assets"
  task :jquery do
    configs = {
      'jquery' => Yano::Jquery::Rails::JQUERY_VERSION,
      'jquery2' => Yano::Jquery::Rails::JQUERY_2_VERSION,
      'jquery3' => Yano::Jquery::Rails::JQUERY_3_VERSION
    }

    Dir.chdir ASSETS_PATH do
      configs.each do |filename, version|
        ['', '.min'].each do |type|
          puts "Downloading #{filename}#{type}.js"
          puts "curl -o ./javascripts/jquery/#{filename}#{type}.js http://code.jquery.com/jquery-#{version}#{type}.js"
          puts `curl -o ./javascripts/jquery/#{filename}#{type}.js http://code.jquery.com/jquery-#{version}#{type}.js`

          puts "Downloading #{filename}#{type}.map"
          puts "curl -o ./source_maps/#{filename}#{type}.map http://code.jquery.com/jquery-#{version}#{type}.map"
          puts `curl -o ./source_maps/#{filename}#{type}.map http://code.jquery.com/jquery-#{version}#{type}.map`
        end
      end
    end

    puts "\e[32mDone!\e[0m"
  end

  desc "Update jQuery UI assets"
  task :jquery_ui do
    version = Yano::Jquery::Rails::JQUERY_UI_VERSION

    Dir.chdir ASSETS_PATH do
      puts `pwd`
      puts "Cleaning temp folder"
      ["rm -rf ", "mkdir -p "].each do |cmd|
        puts "#{cmd} ./tmp ./stylesheets/jquery/ui ./javascripts/jquery/ui ./images/jquery/ui"
        puts `#{cmd} ./tmp ./stylesheets/jquery/ui ./javascripts/jquery/ui ./images/jquery/ui`
      end
      puts "Downloading jquery-ui.zip"
      puts "wget -O ./tmp/jquery-ui.zip http://jqueryui.com/resources/download/jquery-ui-#{version}.zip"
      puts `wget -O ./tmp/jquery-ui.zip http://jqueryui.com/resources/download/jquery-ui-#{version}.zip`
      puts "Unziping jquery-ui.zip"
      puts `unzip -d ./tmp ./tmp/jquery-ui.zip`
      puts "Copy js assets"
      puts "cp ./tmp/jquery-ui-#{version}/jquery-ui*.js javascripts/jquery/ui/"
      puts `cp ./tmp/jquery-ui-#{version}/jquery-ui*.js javascripts/jquery/ui/`
      puts "Copy images assets"
      image_paths = Dir["./tmp/jquery-ui-#{version}/images/*"]
      image_names = image_paths.map {|path| File.basename path }

      image_paths.each do |image_path|
        filename = File.basename image_path

        puts "cp #{image_path} ./images/jquery/ui/#{filename}"
        puts `cp #{image_path} ./images/jquery/ui/#{filename}`
      end

      puts "Copy css assets"
      Dir["./tmp/jquery-ui-#{version}/jquery-ui*.css"].each do |file_path|
        filename = File.basename file_path

        if filename =~ /sctructure/
          puts "cp #{file_path} ./stylesheets/jquery/ui/#{filename}"
          puts `cp #{file_path} ./stylesheets/jquery/ui/#{filename}`
        else
          File.open(file_path, 'r') do |file|
            File.open("./stylesheets/jquery/ui/#{filename}.erb", 'w') do |new_file|
              while (line = file.gets)
                if line =~ /url/i
                  image_names.each do |image|
                    line = line.gsub("url(\"images/#{image}\")", "url(\"<%= asset_path 'jquery/ui/#{image}' %>\")")
                  end
                end

                new_file.puts line
              end
            end
          end
        end
      end

      puts `rm -rf ./tmp`
    end

    puts "\e[32mDone!\e[0m"
  end

  desc "Update jQuery UJS assets"
  task :jquery_ujs do
    puts "Downloading jquery_ujs.js"
    puts `curl -o vendor/assets/javascripts/jquery/jquery_ujs.js https://raw.githubusercontent.com/rails/jquery-ujs/v#{Yano::Jquery::Rails::JQUERY_UJS_VERSION}/src/rails.js`
    puts "\e[32mDone!\e[0m"
  end
end
