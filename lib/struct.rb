class Struct
  ##
  # For some reason Struct.to_json puts out an inspect string.
  # Fix that here.
  def to_json(*args)
    %({#{members.map {|sym| %("#{sym.to_s}":#{self.send(sym).to_json})}.join(',')}})
  end
end