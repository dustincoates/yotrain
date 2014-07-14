require 'nokogiri'

OKAY_STATUSES = ["GOOD SERVICE", "SANDY REROUTE"]

API_KEYS = {
  "123" =>  [ENV['YO_KEY_1'], ENV['YO_KEY_2'], ENV['YO_KEY_3']],
  "456" =>  [ENV['YO_KEY_4'], ENV['YO_KEY_5'], ENV['YO_KEY_6']],
  "7" =>    [ENV['YO_KEY_7']],
  "ACE" =>  [ENV['YO_KEY_A'], ENV['YO_KEY_C'], ENV['YO_KEY_E']],
  "BDFM" => [ENV['YO_KEY_B'], ENV['YO_KEY_D'], ENV['YO_KEY_F'], ENV['YO_KEY_M']],
  "G" =>    [ENV['YO_KEY_G']],
  "JZ" =>   [ENV['YO_KEY_J'], ENV['YO_KEY_Z']],
  "L" =>    [ENV['YO_KEY_L']],
  "NQR" =>  [ENV['YO_KEY_N'], ENV['YO_KEY_Q'], ENV['YO_KEY_R']],
  "S" =>    [ENV['YO_KEY_S']]
}

uri = URI("http://web.mta.info/status/serviceStatus.txt")
res = Net::HTTP.get(uri)
parsed = Nokogiri::XML(res)

parsed.css("service subway line").each do |line|
  if !OKAY_STATUSES.include?(line.css("status").inner_text)
    uri = URI("http://api.justyo.co/yoall/")
    name = line.css("name").inner_text
    unless API_KEYS[name].nil?
      API_KEYS[name].each do |key|
        Net::HTTP::post_form(uri, {api_token: key})
        # Yeah, yeah, I know
        sleep(60)
      end
    end
  end
end
