dir = ARGV.first.split('\\').join('/')
puts "Processing files in #{dir}"

# Get list of files in directory
items = Dir["#{dir}/*"]
# Rejecting directories should also pick up shortcuts in Windows
files = items.reject { |item| File.directory? item }
dirs = items.select { |item| File.directory? item }

def confirm_input
  STDIN.gets.chomp.casecmp('Y').zero?
end

# Process each file
files.each do |f|
  puts
  choice = nil
  loop do
    puts "> #{f}"
    dirs.each.with_index { |d, i| puts "[#{i}] #{d}" }
    puts '[N]ext [R]ename [F]older Create [D]elete [Q]uit'

    choice = STDIN.gets.chomp.upcase

    case choice
    when 'D'
      print "Confirm deleting #{f} [yN] "
      break if confirm_input

      puts 'Not deleting. Choose again'
      next
    when 'R'
      print "Rename #{f} to "
      destination = STDIN.gets.chomp
      destination = File.join(f.split('/')[0..-2], destination)
      puts "Renaming #{f} to #{destination}"
      File.rename(f, destination)
      f = destination
      next
    when 'F'
      print 'Folder name: '
      folder = STDIN.gets.chomp
      folder = File.join(dir, folder)
      dirs << folder
      Dir.mkdir folder
      next
    end

    break if %w[N Q].include?(choice) ||
             (0..dirs.length).map(&:to_s).include?(choice)

    puts 'Invalid choice. Choose again'
  end
  # Logic based on choice
  case choice
  when 'N'
    next
  when 'D'
    # TODO: safe deletes
    File.delete f
  when 'Q'
    break
  else
    index = choice.to_i
    target_dir = dirs[index]
    filename = f.split('/')[-1]
    destination = File.join(target_dir, filename)
    puts "Moving #{f} to #{target_dir}"
    File.rename(f, destination)
  end
end
