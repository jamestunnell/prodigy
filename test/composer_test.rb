require "test_helper"

require "musicality"

class ComposerTest < Minitest::Test
  def test_that_compose_produces_notes
    composer = Prodigy::Composer.new("Cmaj".to_key, "4/4".to_meter, 8)
    notes = composer.compose

    refute_empty notes
  end
end
