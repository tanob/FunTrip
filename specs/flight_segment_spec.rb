require '../flight_segment'
require '../specs/spec_helper'

require 'rubygems'

describe FlightSegment do

  before do
    @xml =
'<Segment>
  <StartDateTime>
    <date>2013-09-04</date>
    <time>15:04:00</time>
  </StartDateTime>
  <EndDateTime>
    <date>2013-09-04</date>
    <time>17:47:00</time>
  </EndDateTime>
  <marketing_airline>G3</marketing_airline>
  <marketing_flight_number>1203</marketing_flight_number>
  <seats>20E</seats>
</Segment>'
  end

  describe 'xml format' do
    it 'should have a xml representation' do

      start_date = DateTime.strptime('2013-09-04 15:04:00', '%Y-%m-%d %H:%M:%S')
      end_date = DateTime.strptime('2013-09-04 17:47:00', '%Y-%m-%d %H:%M:%S')

      flight_segment = FlightSegment.new('G3', '20E', 1203, start_date, end_date)

      flight_segment.to_xml.to_s.should match (@xml)
    end

  end

end