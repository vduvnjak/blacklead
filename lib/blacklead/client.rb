module Blacklead

    # Public: Collection of methods for getting data from graphite. 
    #
    # Examples
    #
    #   cl = Client.new()
    #   url = cl.create_url('FTE_LEVEL_UP_27',5)
    #   response = cl.get_response(url)
    #   min_value = cl.get_min_value(response)
    class Client
        include Api::QueryMethods  #include makes reference on language level to QueryMethods Module

        config_path = 'config/config.yml'
        config = YAML.load(File.read(config_path))
        USER = config['USER'].to_s
        PASS = config['PASS'].to_s
        DOMAIN = config['DOMAIN'].to_s
        SUBDOMAIN = config['SUBDOMAIN'].to_s
        PORT = config['PORT'].to_s

        attr_reader :auth, :domain, :subdomain, :port

        # Public: Initializes basic auth variables.
        #
        # user - username.
        # pass - password.
        # domain - server domain.
        def initialize(user=USER, pass=PASS, domain=DOMAIN, subdomain=SUBDOMAIN, port=PORT)
          @auth = {:username => user, :password => pass}
          @domain = domain
          @subdomain = subdomain
          @port = port
        end

    end

end