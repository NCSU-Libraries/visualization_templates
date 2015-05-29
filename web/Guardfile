# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
#
guard :shell do
  watch(/(.*)/) {|m| `rsync -avh --progress --exclude='.git/' * dlisbox:/var/www/dli/htdocs/jnronall/hunt_wall_templates/.` }
end
