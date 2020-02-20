require 'pathname'

OUT_DIR = Pathname('public')
JAVASCRIPT_PATH = OUT_DIR / 'app.js'
OPAL_PATH = OUT_DIR / 'opal.js'
STYLESHEET_PATH = OUT_DIR / 'app.css'

GEMS = {
  ovto: 'ovto',
}

task default: 'compile:all'

desc 'Watch and compile'
task watch: ['compile:all'] do
  [
    Thread.new { sh "ifchanged #{Dir.glob('lib/**/*.rb').join(' ')} --do 'rake compile:opal'" },
    Thread.new { sh "ifchanged #{Dir.glob('styles/**/*.scss').join(' ')} --do 'rake compile:scss'" },
  ].map(&:join)
end

namespace :compile do
  desc 'Compile opal and scss'
  task all: [:dependency, :opal, :scss]

  desc "Compile opal and scss [production]"
  task production: [:dependency, :'opal:production', :scss, :minify_js]

  desc 'compile .rb to js'
  task :opal do
    sh "opal --no-opal #{GEMS.keys.map { |gem| "--stub #{gem}" }.join(' ')} -c -I lib/ lib/app.rb > #{JAVASCRIPT_PATH}"
  end

  desc 'compile .rb to js [prodcution]'
  task :'opal:production' => :opal

  desc 'compile opal itself'
  task :dependency do
    sh "opal -c #{GEMS.keys.map { |gem| "--gem #{gem}" }.join(' ')} #{GEMS.values.map { |gem| "-r #{gem}" }.join(' ')} -e nil > #{OPAL_PATH}"
  end

  desc 'compile .scss to css'
  task :scss do
    require 'sassc'
    scss = Pathname.glob('styles/**/*.scss').map(&:read).join("\n")
    css = SassC::Engine.new(scss, style: :compressed).render
    File.write(STYLESHEET_PATH, css)
  end

  desc 'minify JavaScript file'
  task :minify_js do
    require 'uglifier'
    OUT_DIR.glob('*.js') do |js_path|
      new_code = Uglifier.compile(File.read(js_path), harmony: true)
      File.write(js_path, new_code)
    end
  end
end
