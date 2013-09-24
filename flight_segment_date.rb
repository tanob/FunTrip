require 'roxml'

class FlightSegmentDate
  include ROXML

  @date = DateTime.new
  xml_reader :date
  xml_reader :time

  def initialize(date)
    @date = date
  end

  private

  def date
   @date.strftime('%Y-%m-%d')
  end

  def time
    @date.strftime('%H:%M:%S')
  end

end