module Blacklead
  module Api
    module QueryMethods

      require 'net/https'
      require 'uri'
      require 'httparty'
      require 'yaml'

      # Public: Get response from server using crafted url and authorization values.
      #
      # url - prepared url.
      # options - additional options besides basic authorization.
      #
      # Examples
      #
      #   response = cl.get_response(url)
      #   # => <HTTParty::Response:0x1010dc120 parsed_response="stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0\n", 
      #        @response=#<Net::HTTPOK 200 OK readbody=true>, @headers={"server"=>["nginx/1.0.8"], "date"=>["Wed, 08 Aug 2012 22:18:53 GMT"], 
      #        "content-type"=>["text/plain; charset=UTF-8"], "transfer-encoding"=>["chunked"], "connection"=>["close"]}
      #
      # Returns string in format # => "stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0".
      def get_response(url, options={})
        options.merge!({:basic_auth => @auth})
        response = HTTParty.get(url, options)
        pr = response.parsed_response
        #in some instances, response ends with \n, so
        pr = pr.chomp if pr[-1,2] == "\n"
      end

      # Public: Creates url for HTTP call.
      #
      # target - event we want data for.
      # from - how many minutes ago we want data.
      #
      # Examples
      #
      #   url = cl.create_url('FTE_LEVEL_UP_27',5)
      #   # => 'https://ewstatsd.wonderhill.com:6565/render?target=stats.FTE_LEVEL_UP_27&from=-5minute&rawData=true'
      #
      # Returns url string 
      def create_url (target,from)
        url = 'https://'+@subdomain+'.'+@domain+':'+@port+'/render?target=stats.'+target.to_s+'&from=-'+from.to_s+'minute&rawData=true'
      end  

      # Public: Returns values from parsed string.
      #
      # result_string - string we get from http call.
      #
      # Examples
      #
      #   values = cl.get_values("stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0")
      #   # => '1.0,1.0,1.0,0.0,1.0'
      #
      # Returns string of values 
      def get_values (result_string)
        pieces = result_string.split("|")
        pieces[1].split(",")
      end

      # Public: Returns event from parsed string.
      #
      # result_string - string we get from http call.
      #
      # Examples
      #
      #   event = cl.get_event("stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0")
      #   # => 'FTE_LEVEL_UP_27'
      #
      # Returns string  
      def get_event (result_string)
        pieces = result_string.split("|")
        pieces[0].split(",")[0].split(".")[1]
      end

      # Public: Check if there is missing value in parsed string.
      #
      # result_string - string we get from http call.
      #
      # Examples
      #
      #   valid = cl.check_values("stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0")
      #   # => true
      #
      # Returns boolean  
      def check_values (result_string)
        values = get_values(result_string)
        !values.include?('None')
      end

      # Public: gets sum of values in parsed string.
      #
      # result_string - string we get from http call.
      #
      # Examples
      #
      #   sum = cl.get_sum_values("stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0")
      #   # => 4.0
      #
      # Returns float  
      def get_sum_values (result_string)
        values = get_values(result_string).map { |x| x.to_f }
        values.inject{ |sum, el| sum + el }.to_f
      end

      # Public: gets avg value in parsed string.
      #
      # result_string - string we get from http call.
      #
      # Examples
      #
      #   avg = cl.get_avg_value("stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0")
      #   # => 0.8
      #
      # Returns float  
      def get_avg_value (result_string)
        values = get_values(result_string).map { |x| x.to_f }
        values.inject{ |sum, el| sum + el }.to_f / values.size
      end

      # Public: gets max value in parsed string.
      #
      # result_string - string we get from http call.
      #
      # Examples
      #
      #   max = cl.get_max_value("stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0")
      #   # => 1.0
      #
      # Returns float  
      def get_max_value (result_string)
        values = get_values(result_string).map { |x| x.to_f }
        values.max
      end

      # Public: gets min value in parsed string.
      #
      # result_string - string we get from http call.
      #
      # Examples
      #
      #   min = cl.get_min_value("stats.FTE_LEVEL_UP_27,1344464040,1344464340,60|1.0,1.0,1.0,0.0,1.0")
      #   # => 0.0
      #
      # Returns float 
      def get_min_value (result_string)
        values = get_values(result_string).map { |x| x.to_f }
        values.min
      end


    end
  end
end