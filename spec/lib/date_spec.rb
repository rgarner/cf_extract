require 'spec_helper'

describe Date do
  specify { Date.civil(2011, 1, 31).quarter.should == 1 }
  specify { Date.civil(2011, 4, 30).quarter.should == 2 }
  specify { Date.civil(2011, 7, 1).quarter.should == 3 }
  specify { Date.civil(2011, 10, 20).quarter.should == 4 }
end