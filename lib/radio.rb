require 'httparty'

class Radio
  include HTTParty

  HEADERS = { headers: { 'Content-Type' => 'application/json' }}
  BASE_URI = "http://localhost/api/v1/"
  EXPECTED_RESPONSE_CODES = [200, 201]

  def initialize(type)
    @type = type
    @objects = []
  end

  def search(keywords)
    response = HTTParty.get( BASE_URI + @type + "?q=#{keywords}", HEADERS)
    if EXPECTED_RESPONSE_CODES.include? response.code
      records = RecordsSerializer.new(response.body)
      @objects = records.to_objects_array
    end
  end

  def get_list
    response = HTTParty.get( BASE_URI + @type, HEADERS)

    if EXPECTED_RESPONSE_CODES.include? response.code
      records = RecordsSerializer.new(response.body)
      @objects = records.to_objects_array
    end
  end

  def get_item(id)
    response = HTTParty.get( BASE_URI + @type + '/' + id.to_s, HEADERS)
    if EXPECTED_RESPONSE_CODES.include? response.code
      record = RecordsSerializer.new(response.body)
      record.to_object
    end
  end

  def create(note)
    message = prepare_json(note)
    send_post(message)
  end

  def update(note, id)
    message = prepare_json(note)
    send_patch(message, id)
  end

  def prepare_json(note)
    translator = Translator.new(note).to_api_format.to_json
  end

  def send_post(msg, id='')
    response = HTTParty.post( BASE_URI + "notes", HEADERS.merge({ body: msg}))
    EXPECTED_RESPONSE_CODES.include? response.code
  end

  def send_patch(msg, id='')
    response = HTTParty.patch( BASE_URI + "notes/#{id}", HEADERS.merge({ body: msg}))
    EXPECTED_RESPONSE_CODES.include? response.code
  end

  def print_list
    @type.singularize.capitalize.constantize.send(:print_list, get_list)
  end

  def show(id)
    get_item(id).show
  end
end
