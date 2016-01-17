class Note

  attr_accessor :id, :title, :body, :tags

  def initialize(attrs={})
    @id = attrs["id"]
    @title = attrs["attributes"]["title"]
    @body = attrs["attributes"]["body"]

    if attrs.has_key?("tags") && attrs["tags"]
      @tags = attrs["tags"].map { |tag| tag["attributes"]["name"] }
    end
  end

  def show
    puts "Showing Note #{id}".upcase
    puts "-" * 70
    print " " + "Title".ljust(10)
    print " " + self.title + "\n"
    print " " + "Body".ljust(10)
    print " " + self.body + "\n"
    print " " + "Tags".ljust(10)
    print " " + self.tags.join(', ') if self.tags
    print "\n"
    puts "-" * 70
  end

  def self.print_list(list)
    puts "Notes Listing".upcase
    puts "-" * 70
    print " " + "ID".ljust(6)
    print " " + "Title".ljust(20)
    print " " + "Body".ljust(40) + "\n"
    puts "-" * 70
    list.each do |note|
      line =  " " << note.id.to_s.ljust(6)
      line << " " + note.title.truncate(15).ljust(20)
      line << " " + note.body.truncate(35).ljust(40)
      puts line
    end
    puts "No listings found" if list.empty?
    puts "-" * 70
  end

  def to_s
    puts "#{self.id}".ljust(6) + "(Note) #{self.title}".ljust(20)
  end

end
