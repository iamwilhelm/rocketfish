require 'date'

def compile(filepath)
  base = File.basename(filepath, File.extname(filepath))
  IO.popen("openscad -o print/#{base}.stl #{filepath}") { |f|
    f.each { |l| puts l }
  }
end

def timestamp_compile
  File.open(".compileTime", 'w') { |f| f.write(Time.now.to_s) }
end

def read_timestamp
  File.open(".compileTime", 'r') { |f| DateTime.parse(f.readline) }
end

def changedFiles(path)
  lastCompile = read_timestamp
  Dir.glob(path) do |path|
    yield path if lastCompile.to_time < File.stat(path).mtime
  end
end

task :default => :compile

desc "Setups up the project"
task :setup do
  %w(photos print src scad_modules).each do |name|
    puts "Creating #{name}/"
    `mkdir -p #{name}`
  end
  puts "Timestamp compile time"
  timestamp_compile
  puts "Finished setup"
end

desc "compile changed files or do FORCE=true to force compile all"
task :compile => "compile:default"

namespace :compile do
  task :default do
    changedFiles("src/*.scad") do |path|
      puts "compiling #{path}..."
      compile(path)
    end
    timestamp_compile
  end

  task :force do
    Dir.glob("src/*.scad") do |path|
      puts "compiling #{path}..."
      compile(path)
    end
    timestamp_compile
  end
end

