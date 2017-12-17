task :default do system 'rake -T' end

desc 'convert latex to md' task :latex2md do p file = ARGV\[1\] p tmp =
'tmp.md' system "pandoc -s \#{file} -o \#{tmp}" lines =
File.readlines(tmp) cont = "" lines.each do |line| line =
delete\_label(line) cont &lt;&lt; change\_eps\_jpg(line) end print cont
exit end

def delete\_label(line) if m=line.match(/\\label{(.+?)}(.+)/) line =
m\[2\] end return line end

def change\_eps\_jpg(line) line.gsub('.eps','.jpg') end
