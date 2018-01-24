Dir.entries('.')[2..-1].each do |file|
  if file.match(/.+(_E).+/)
    puts "![](LPSO2016/#{file})"
  end
end
