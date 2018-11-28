#
#  how to use
#  please type the command of next line.
#  >ruby latex.rb paper.txt
#

require 'pp'
require 'kconv'
require 'fileutils'

filename = ARGV[0]
infile = File.read(filename)

text = NKF.nkf("-Ws",infile) # require 'kconv'

File.open(filename,'w')do |f|
  f.write text
end
head = filename.split(/\./).shift

Dir.chdir(Dir.pwd+"/Figure"){
  system 'ebb '+'*.jpg'
}
system 'mv '+filename+' '+head+'.tex'
system 'platex '+head+'.tex'
system 'dvipdfmx '+head+'.dvi'
system 'open '+head+'.pdf'
