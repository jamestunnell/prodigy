require "test_helper"

class ProdigyTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Prodigy::VERSION
  end
end
