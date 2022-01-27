def load_aliases_from(alias_file_location) : Hash(String, String)
  hash = Hash(String, String).new
  if !File.exists?(alias_file_location)
    return hash
  end
  File.each_line(alias_file_location) do |line|
    values = line.split("=")
    first = values[0]
    name = first.split(" ")[1]
    path = values[1]
    hash[name] = path
  end
  hash
end

def get_output_for(aliases : Hash(String, String), prefix = false)
  a = Array(String).new
  aliases.each do |name, path|
    line = "#{name}=#{path}"
    if prefix
      line = "alias #{line}"
    end
    a << line
  end
  output = a.sort!.join("\n")
end

def update_aliases(hash, alias_file_location)
  if File.exists?(alias_file_location) && !File.empty?(alias_file_location)
    File.copy(alias_file_location, "#{alias_file_location}.bak")
  end
  File.write(alias_file_location, get_output_for(hash, true))
end

alias_file_location = Path["~/.alias"].expand(home: true)
hash = load_aliases_from(alias_file_location)
new_name = ARGV[0]?
command = ARGV[1]?

if new_name
  if command == "-d"
    puts "Deleting alias [#{new_name}]"
    hash.delete new_name
  else
    puts "Adding alias [#{new_name}]"
    current_dir = Dir.current
    puts "Path of [#{current_dir}]"
    hash[new_name] = "'#{current_dir}'"
  end
  update_aliases(hash, alias_file_location)
end

puts "---------------"
puts "Current aliases"
puts "---------------"
puts get_output_for(hash)