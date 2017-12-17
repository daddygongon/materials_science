#! /usr/bin/env ruby
# -*- coding: utf-8 -*-

PRE, PLAIN, FIGURE = 0,1,2
EQUATION, EQNARRAY = 3,4
MAPLE = 5
def check(line)
  line, $status = "", PLAIN if line.match(/\\begin{document}/)
  line, $status = "", PRE if line.match(/\\end{document}/)
  line, $status = line, FIGURE if line.match(/\\begin{figure}/)
  line, $status = line, PLAIN if line.match(/\\end{figure}/)
  line, $status = line, EQUATION if line.match(/\\begin{equation}/)
  line, $status = "$$\n", PLAIN if line.match(/\\end{equation}/)
  line, $status = line, EQUATION if line.match(/\\begin{eqnarray}/)
  line, $status = "$$\n", PLAIN if line.match(/\\end{eqnarray}/)
  line, $status = line, MAPLE if line.match(/\\begin{maplegroup}/)
  line, $status = "", MAPLE if line.match(/\\end{maplegroup}/)
  return line
end

def plain_action(line)
  if m = line.match(/\\section{(.+)}/)
    line = "\# #{m[1]}\n"
  elsif m = line.match(/\\subsection{(.+)}/)
    line = "\#\# #{m[1]}\n"
  elsif m = line.match(/\\subsubsection{(.+)}/)
    line = "\#\#\# #{m[1]}\n"
  end
  return line
end

def figure_action(line)
#  p line
end

def equation_action(line)
  if m = line.match(/\\begin{equation}/)
    line = "$$\n"
  elsif m = line.match(/\\label/)
    line = ""
  end
  return line
end

def eqnarray_action(line)
  if m = line.match(/\\begin{eqnarray}/)
    line = "$$\n"
  elsif m = line.match(/\\label/)
    line = ""
  end
  return line
end

p source = ARGV[0] 
p target = source.split('.')[0]+'.ipynb'

lines = File.readlines(source)
target_file = File.open(target, 'w')
contents = ""
$status = PRE

lines.each do |line|
  line = check(line)
  line =  case $status
  when PLAIN;     plain_action(line)
  when FIGURE;    figure_action(line)
  when EQUATION;  equation_action(line)
  when EQNARRAY;  eqnarray_action(line)
  when MAPLE;  ""
  end
  contents << line.to_s
end

print contents
