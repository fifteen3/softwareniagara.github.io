task :server do
  server  = Process.spawn('jekyll serve --watch')
  compass = Process.spawn('compass watch')

  trap('INT') do
    [server, compass].each { |pid| Process.kill(9, pid) rescue Errno::ESRCH }
    exit 0
  end

  [server, compass].each { |pid| Process.wait(pid) }
end