require 'readline'

class Notebook

  @@valid_actions = ['list', 'show', 'find', 'add', 'edit', 'quit']
  @@action_options = ['[notes|tags]  | ', '[note|tag] [id]  | ', '[string]  | ', '  | ', 'note [id] | ']

  def run
    output_introduction
    # action loop
    result = nil
    until result == :quit
      action, args = get_action
      result = do_action(action, args)
    end
    output_conclusion
  end

  private

  def get_action
    action = nil
    # Keep asking for user input until we get a valid action
    until @@valid_actions.include?(action)
      puts "Action not recognized." if action
      output_valid_actions
      user_response = user_input('> ')
      args = user_response.downcase.split(' ')
      action = args.shift
    end
    return action, args
  end

  def do_action(action, args=[])
    case action
    when 'list'
      list(args)
    when 'show'
      show(args)
    when 'find'
      find(args)
    when 'add'
      add
    when 'edit'
      edit(args)
    when 'quit'
      return :quit
    end
  end

  def list(args=[])
    type = safe args.shift
    records = Radio.new(type)
    records.print_list
  end

  def show(args=[])
    type = safe args.shift.pluralize
    id = args.shift.to_i
    record = Radio.new(type)
    record.show(id) if id
  end

  def add
    output_action_header("Add a note")
    attributes = note_attribute_input
    note = Radio.new('notes')

    if note.create(attributes)
      puts "\nNote Added\n\n"
    else
      puts "\nSave Error: Note not added\n\n"
    end
  end

  def edit(args)
    id = args.last
    output_action_header("Edit a note")
    attributes = note_attribute_input

    note = Radio.new('notes')

    if note.update(attributes, id)
      puts "\nNote Updated\n\n"
    else
      puts "\nSave Error: Note not updated\n\n"
    end
  end

  def find(args)
    keywords = args.join(' ')
    results = Radio.new('search')
    list = results.search(keywords)
    puts "Search results".upcase
    puts "-" * 70
    print " " + "ID".ljust(6)
    print " " + "Identifier".ljust(20) + "\n"
    puts "-" * 70
    puts list.map(&:to_s)
    puts "-" * 70
  end

  def output_action_header(text)
    puts "\n#{text.upcase.center(60)}\n\n"
  end

  def output_valid_actions
    puts "Actions: " + @@valid_actions.zip(@@action_options).flatten.join(' ')
  end

  def output_introduction
    puts "\n\n<<< Welcome to Notes CLI APP >>>\n\n"
    puts "This is an interactive app to help keep your notes organized.\n\n"
  end

  def output_conclusion
    puts "\n<<< Goodbye and See you soon! >>>\n\n\n"
  end

  def note_attribute_input
      args = {}
      print "Note title: "
      args[:title] = user_input('')

      print "Note body: "
      args[:body] = user_input('')

      print "Note tags (comma separated): "
      args[:tags] = user_input('')

      return args
    end

  def user_input(prompt=nil)
    prompt ||= '> '
    result = Readline.readline(prompt, true)
    result.strip
  end

  def safe(type)
    key = type || 'notes'
  end
end
