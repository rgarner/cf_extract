class Date
  ##
  # The quarter for this date. 1, 2, 3 or 4.
  def quarter
    ((self.month - 1) / 3) + 1
  end
end