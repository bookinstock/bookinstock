newdir = 'newdir'
newfile = 'newfile'
Dir.mkdir(newdir)
Dir.chdir(newdir) do
  File.open(newfile, 'w') do |f|
    f.puts "sample file"
  end
  puts "current dir: #{Dir.pwd}"
  puts "Dir listing: "
  p Dir.entries('.')
  File.unlink(newfile)
end
Dir.rmdir(newdir)
puts File.exist?(newdir) ? "yes" : "no"