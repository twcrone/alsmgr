alias_file_location = Path.home.to_s + "/.alias"
hash = Hash(String, String).new
File.each_line(alias_file_location) do |line|
  values = line.split("=")
  first = values[0]
  name = first.split(" ")[1]
  path = values[1]
  hash[name] = path
end

hash.each do |name, path|
  puts name + "=" + path
end