require 'roxml'
require '../flight_segment_date'

class FlightSegment
  include ROXML

  xml_name 'Segment'
  xml_reader :start_date, :as => FlightSegmentDate, :from => 'StartDateTime'
  xml_reader :end_date, :as => FlightSegmentDate, :from => 'EndDateTime'
  xml_reader :marketing_airline
  xml_reader :flight_number, :as => Integer, :from => 'marketing_flight_number'
  xml_reader :seat, :from => 'seats'

  def initialize(marketing_airline, seat, flight_number, start_date, end_date)
    @marketing_airline = marketing_airline
    @seat = seat
    @flight_number = flight_number
    @start_date = FlightSegmentDate.new(start_date)
    @end_date = FlightSegmentDate.new(end_date)

  end

end