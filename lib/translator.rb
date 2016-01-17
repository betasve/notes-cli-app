class Translator

  def initialize(msg)
    @msg = msg
  end

  def to_api_format
    {
      data: {
        attributes: { title: @msg[:title], body: @msg[:body] },
      },
      relationships: {
        tags: {
          data: @msg[:tags].split(',').map{ |tag| { attributes: { name: tag }}}
        }
      }
    }
  end

end
