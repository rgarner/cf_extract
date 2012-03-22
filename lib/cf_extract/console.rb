def long_operation(message = "In progress ... ", done_message = 'Done.')
  raise ArgumentError, 'Block required' unless block_given?

  print message
  STDOUT.flush

  yield.tap do
    print "#{done_message}\n"
  end
end