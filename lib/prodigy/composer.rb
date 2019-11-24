require "musicality"

module Prodigy

class Composer
  attr_reader :key, :meter, :high_level_rhythms

  def initialize(key, meter)
    @key = key
    @meter = meter

    @high_level_rhythms = Array.new(rand(1..4)) { |i| Composer.make_high_level_rhythm(@meter) }
  end

  def self.randomly_consolidate_portions portions, consolidate_prob
    # randomly sum together zero or more of the portions
    new_portions = []
    i = 0
    while(i < portions.size) do
      if i == (portions.size - 1) || rand() > consolidate_prob
        new_portions.push(portions[i])
        i += 1
      else
        new_portions.push(portions[i] + portions[i+1])
        i += 2
      end
    end
    return new_portions
  end

  def self.make_high_level_rhythm meter
    portions = Array.new(meter.beats_per_measure, 1)
    portions = randomly_consolidate_portions(portions, 0.3)
    portions = randomly_consolidate_portions(portions, 0.3)

    rc = Musicality::RhythmClass.new(portions)
    rc.to_rhythm(meter.measure_duration)
  end

  MAJOR_SCALE_CLASS = Musicality::ScaleClasses::Heptatonic::Prima::MAJOR
  def compose measure_count

    tonic_scale = MAJOR_SCALE_CLASS.to_scale(@key.tonic_pc)
    scale_pitches = tonic_scale.at_octave(2).take(8).to_a

    notes = []
    measure_count.times do |i|
      rhythm = @high_level_rhythms.sample
      new_notes = rhythm.durations.map {|dur| Musicality::Note.new(dur, scale_pitches.sample) }
      notes.push new_notes
    end

    return notes
  end
end

end
