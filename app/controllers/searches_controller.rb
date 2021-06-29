require 'uri'
require 'net/http'
require 'openssl'

class SearchesController < ApplicationController
    def index
        url = URI("https://shazam.p.rapidapi.com/search?term=#{params['term']}")
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
            request = Net::HTTP::Get.new(url)
            request["x-rapidapi-key"] = '6d4d8a6cd6mshe71720ae222ee71p14c900jsn605699b2c370'
            request["x-rapidapi-host"] = 'shazam.p.rapidapi.com'
    
            response = http.request(request)
            puts response.read_body

            render json: response.read_body

    end

end
