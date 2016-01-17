class Tag

  attr_accessor :id, :name, :notes

  def initialize(attrs={})
    @id = attrs["id"]
    @name = attrs["attributes"]["name"]

    if attrs.has_key?("notes") && attrs["notes"]
      @notes = attrs["notes"].map do |note|
        {
          id: note["id"],
          title: note["attributes"]["title"]
        }
      end
    end
  end

  def show
    puts "Showing Tag #{name}".upcase
    puts "-" * 70
    puts "Notes with that tag"
    puts "-" * 70
    self.notes.each do |note|
      print " " + note[:id].to_s.ljust(6)
      print " " + note[:title].ljust(50) + "\n"
    end
    puts "No notes with that tag" if self.notes.empty?
    print "\n"
    puts "-" * 70
  end

  def self.print_list(list)
    print " " + "ID".ljust(6)
    print " " + "Name".ljust(20) + "\n"
    puts "-" * 30
    list.each do |tag|
      line =  " " << tag.id.to_s.ljust(6)
      line << " " + tag.name.truncate(20).ljust(20)
      puts line
    end
    puts "No listings found" if list.empty?
    puts "-" * 30
  end

  def to_s
    puts "#{self.id}".ljust(6) + "(Tag) #{self.name}".ljust(20)
  end

end
