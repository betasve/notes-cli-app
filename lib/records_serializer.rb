class RecordsSerializer

  def initialize(response_body)
    @body = JSON.parse(response_body)
  end

  def to_objects_array
    objectize_many
  end

  def to_object
    objectize_one
  end

  private

  def objectize_many
    objects = []
    @body["data"].each do |record|
      objects << record["type"].singularize.capitalize.constantize.send(:new, record)
    end
    objects
  end

  def objectize_one
    type = @body["data"]["type"]
    rel_type = "notestags".gsub(type, '').chomp
    @body["data"][rel_type] = @body["relationships"][rel_type]["data"]
    type.singularize.capitalize.constantize.send(:new, @body["data"])
  end
end
