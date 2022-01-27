def load_aliases_from(alias_file_location) : Hash(String, String)
  hash = Hash(String, String).new
  File.each_line(alias_file_location) do |line|
    values = line.split("=")
    first = values[0]
    name = first.split(" ")[1]
    path = values[1]
    hash[name] = path
  end
  hash
end

def get_output_for(aliases : Hash(String, String))
  a = Array(String).new
  aliases.each do |name, path|
    a << name + "=" + path
  end
  output = a.sort!.join("\n")
end

alias_file_location = Path["~/.alias"].expand(home: true)
hash = load_aliases_from(alias_file_location)
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

if !File.empty?(alias_file_location)
  File.copy(alias_file_location, "#{alias_file_location}.bak")
end
new_file_content = ""

aliases.each do |s|
  new_file_content += "alias #{s}\n"
end

print_aliases hash