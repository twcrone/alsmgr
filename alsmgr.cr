alias_file_location = Path["~/.alias"].expand(home: true)
hash = Hash(String, String).new
File.each_line(alias_file_location) do |line|
  values = line.split("=")
  first = values[0]
  name = first.split(" ")[1]
  path = values[1]
  hash[name] = path
end

new_name = ARGV[0]?

if new_name
  current_dir = Dir.current
  hash[new_name] = "'#{current_dir}'"
end

aliases = Array(String).new

hash.each do |name, path|
  aliases << name + "=" + path
end

aliases.sort!

aliases.each do |s|
  puts s
end