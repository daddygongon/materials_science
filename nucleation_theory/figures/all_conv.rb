Dir.entries('./back_ups')[2..-1].each do |file|
  p file
  p backup_file = File.join('back_ups',file)
  p command = "convert #{backup_file} -resize 50% tmp.png"
  system command
  p command = "mv tmp.png #{file}"
  system command
end

