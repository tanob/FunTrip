require 'bundler'
Bundler.setup :default

require 'tripit'

cred = TripIt::OAuthCredential.new('', '', '', '')
t = TripIt::API.new(cred)
trip_xml = "<Request><Trip><is_private>true</is_private><start_date>2013-12-09</start_date><end_date>2013-12-27</end_date><primary_location>NY</primary_location></Trip></Request>"
trip_obj = t.create(trip_xml)
puts trip_obj.to_xml.to_s

trip_id = trip_obj[TripIt::Trip].first['id']

air_xml = <<EOS
<Request>
  <AirObject>
    <trip_id>#{trip_id}</trip_id>
    <supplier_conf_num>ABC123</supplier_conf_num>
    <Segment>
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
    </Segment>
    <Segment>
      <StartDateTime>
        <date>2013-09-08</date>
        <time>16:32:00</time>
      </StartDateTime>
      <EndDateTime>
        <date>2013-09-08</date>
        <time>22:42:00</time>
      </EndDateTime>
      <marketing_airline>G3</marketing_airline>
      <marketing_flight_number>1214</marketing_flight_number>
      <seats>6B</seats>
    </Segment>
  </AirObject>
</Request>
EOS

air_obj = t.create(air_xml.lines.map(&:strip).join(''))

