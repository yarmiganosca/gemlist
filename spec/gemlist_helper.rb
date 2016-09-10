require "spec_helper"
require "pathname"
require "gemlist"

def test_project
  Pathname.new(File.dirname(__FILE__))/"support"/"project"
end
