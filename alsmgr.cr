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

def get_print_output_for(aliases : Hash(String, String))
  a = Array(String).new
  aliases.each do |name, path|
    a << "#{name}=#{path}"
  end
  output = a.sort!.join("\n")
end

def get_alias_output_for(aliases : Hash(String, String))
  a = Array(String).new
  aliases.each do |name, path|
    a << "alias #{name}=#{path}"
  end
  output = a.sort!.join("\n")
end

def update_aliases(hash, alias_file_location)
  if !File.empty?(alias_file_location)
    File.copy(alias_file_location, "#{alias_file_location}.bak")
  end
  File.write(alias_file_location, get_alias_output_for(hash))
end

alias_file_location = Path["~/.alias"].expand(home: true)
hash = load_aliases_from(alias_file_location)
new_name = ARGV[0]?
command = ARGV[1]?

if new_name
  if command == "-d"
    hash.delete new_name
  else
    current_dir = Dir.current
    hash[new_name] = "'#{current_dir}'"
  end
  update_aliases(hash, alias_file_location)
end

puts get_print_output_for(hash)