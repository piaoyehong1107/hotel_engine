require 'uri'
require 'net/http'
require 'openssl'

class SearchesController < ApplicationController
    def index
        url = URI("https://shazam.p.rapidapi.com/search?term=#{params['term']}")
        @result = Search.find_by(term: params['term'])
        
        if !@result
            puts '==> fetch data from API'
            http = Net::HTTP.new(url.host, url.port)
            http.use_ssl = true
            http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    
            request = Net::HTTP::Get.new(url)
            request["x-rapidapi-key"] = ENV['API_KEY']
            request["x-rapidapi-host"] = 'shazam.p.rapidapi.com'
    
            response = http.request(request)
            puts response.read_body

            resp_json = JSON.parse(response.read_body)

            Search.create(
                term: params['term'],
                data: resp_json["tracks"]["hits"]
            )

            @result2 = Search.find_by(term: params['term'])
            render json: @result2
        else
            puts '==> fetch data from db'
            render json: @result.as_json()
        end

    end

end
