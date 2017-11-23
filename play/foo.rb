def foo
  fh = File.open(filename)
rescue => e
  logfile.puts("try to open #{filename}, #{Time.now}")
  logfile.puts("exception: #{e.message}")
  raise # raise again
end