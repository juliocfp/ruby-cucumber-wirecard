class Payment < Order
    def get_payment(payment_id)
        HTTParty.get("https://sandbox.moip.com.br/v2/payments/#{payment_id}",
            :basic_auth => {username: $username, password: $password})
    end

    def return_payment_id(json_string)
        parsed_json = JSON.parse(json_string)
        parsed_json['id']
    end

    def return_payment_own_id(json_string)
        parsed_json = JSON.parse(json_string)
        parsed_json['ownId']
    end

    def return_payment_customer_name(json_string)
        parsed_json = JSON.parse(json_string)
        parsed_json['customer']['fullname']
    end

    def return_payment_amount(json_string)
        parsed_json = JSON.parse(json_string)
        parsed_json['amount']['total']
    end

    def set_valid_request_payment
        @fundingInstrument_creditCard_id = "CRC-K721FWGX4K6L"
        @fundingInstrument_creditCard_holder_taxDocument_type = "CPF"
    end

    def set_invalid_request_payment(type)
        set_valid_request_payment
        case type
        when "creditCard_id"
            @fundingInstrument_creditCard_id = ""
        when "documentType"
            @fundingInstrument_creditCard_holder_taxDocument_type = ""
        else
            puts "valor para troca não encontrado"
        end
    end

    def post_payment
        set_valid_request
        order_id = return_order_id(post_order.body)
        @order_id_again = order_id
        puts order_id
        HTTParty.post("https://sandbox.moip.com.br/v2/orders/#{order_id}/payments",
            :basic_auth => {username: $username, password: $password},
            :headers => { 'Content-Type' => 'application/json'},
            :body => {
                "installmentCount": 1,
                "statementDescriptor": "videogames",
                "fundingInstrument": {
                  "method": "CREDIT_CARD",
                  "creditCard": {
                    "id": @fundingInstrument_creditCard_id,
                    "hash": "MBQSo0e8tt4KqC7iwWtUb/Iybf56wphvkt6PI6mOB6jLFSemfabRxwZAuja+Qu0ju9A8Qqr5papxWp72tCjiCROhE+vYr6w0qr9lWQa+n5AIiUgy4OPDrYFkYX7Teow1pzAV+NDYKwuMNo34xky+AMQMUbR3z1XdwDzLZK7wtRZeW2cGSBI7GRCzFT7e+bBhmTykEo8yMgN/Lw3Z67Kl8aMEAlexGYMfrtBEraxF+X1JcuT3nGqbK3m9GlhEGPY4KLzh7qEXbpN1MuRbczzE0DcY7pUag/Cge6JbUxl3w5IyxJsBEMWKv8XlvwUKWVSk4Arh9jLM55Gfl6r+C7GfWA==",
                    "store": true,
                    "holder": {
                      "fullname": "Russel Westbrook",
                      "birthdate": "1990-10-22",
                      "taxDocument": {
                        "type": @fundingInstrument_creditCard_holder_taxDocument_type,
                        "number": "22288866644"
                      },
                      "phone": {
                        "countryCode": "55",
                        "areaCode": "11",
                        "number": "66778899"
                      }
                    }
                  }
                },
                "device": {
                  "ip": "127.0.0.1",
                  "geolocation": {
                    "latitude": -33.867,
                    "longitude": 151.206
                  },
                  "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36",
                  "fingerprint": "QAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolp"
                }
              }.to_json)
    end

    def post_payment_especific(order_id)
        set_valid_request
        HTTParty.post("https://sandbox.moip.com.br/v2/orders/#{order_id}/payments",
            :basic_auth => {username: $username, password: $password},
            :headers => { 'Content-Type' => 'application/json'},
            :body => {
                "installmentCount": 1,
                "statementDescriptor": "videogames",
                "fundingInstrument": {
                  "method": "CREDIT_CARD",
                  "creditCard": {
                    "id": @fundingInstrument_creditCard_id,
                    "hash": "MBQSo0e8tt4KqC7iwWtUb/Iybf56wphvkt6PI6mOB6jLFSemfabRxwZAuja+Qu0ju9A8Qqr5papxWp72tCjiCROhE+vYr6w0qr9lWQa+n5AIiUgy4OPDrYFkYX7Teow1pzAV+NDYKwuMNo34xky+AMQMUbR3z1XdwDzLZK7wtRZeW2cGSBI7GRCzFT7e+bBhmTykEo8yMgN/Lw3Z67Kl8aMEAlexGYMfrtBEraxF+X1JcuT3nGqbK3m9GlhEGPY4KLzh7qEXbpN1MuRbczzE0DcY7pUag/Cge6JbUxl3w5IyxJsBEMWKv8XlvwUKWVSk4Arh9jLM55Gfl6r+C7GfWA==",
                    "store": true,
                    "holder": {
                      "fullname": "Russel Westbrook",
                      "birthdate": "1990-10-22",
                      "taxDocument": {
                        "type": @fundingInstrument_creditCard_holder_taxDocument_type,
                        "number": "22288866644"
                      },
                      "phone": {
                        "countryCode": "55",
                        "areaCode": "11",
                        "number": "66778899"
                      }
                    }
                  }
                },
                "device": {
                  "ip": "127.0.0.1",
                  "geolocation": {
                    "latitude": -33.867,
                    "longitude": 151.206
                  },
                  "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36",
                  "fingerprint": "QAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolp"
                }
              }.to_json)
    end

    def post_invalid_structure_payment
        set_valid_request
        order_id = return_order_id(post_order.body)
        puts order_id
        HTTParty.post("https://sandbox.moip.com.br/v2/orders/#{order_id}/payments",
            :basic_auth => {username: $username, password: $password},
            :headers => { 'Content-Type' => 'application/json'},
            :body => {
                "installmentCount": 1,
                "statementDescriptor": "videogames",
                "fundingInstrument": {
                  "method": "CREDIT_CARD",
                  "creditCard": {
                    "id": @fundingInstrument_creditCard_id,
                    "hash": "MBQSo0e8tt4KqC7iwWtUb/Iybf56wphvkt6PI6mOB6jLFSemfabRxwZAuja+Qu0ju9A8Qqr5papxWp72tCjiCROhE+vYr6w0qr9lWQa+n5AIiUgy4OPDrYFkYX7Teow1pzAV+NDYKwuMNo34xky+AMQMUbR3z1XdwDzLZK7wtRZeW2cGSBI7GRCzFT7e+bBhmTykEo8yMgN/Lw3Z67Kl8aMEAlexGYMfrtBEraxF+X1JcuT3nGqbK3m9GlhEGPY4KLzh7qEXbpN1MuRbczzE0DcY7pUag/Cge6JbUxl3w5IyxJsBEMWKv8XlvwUKWVSk4Arh9jLM55Gfl6r+C7GfWA==",
                    "store": true,
                    "holder": {
                      "fullname": "Russel Westbrook",
                      "birthdate": "1990-10-22",
                      "taxDocument": {
                        "type": @fundingInstrument_creditCard_holder_taxDocument_type,
                        "number": "22288866644"
                      },
                      "phone": {
                        "countryCode": "55",
                        "areaCode": "11",
                        "number": "66778899"
                      }
                    }
                  }
                },
                "device": {
                  "ip": "127.0.0.1",
                  "geolocation": {
                    "latitude": -33.867,
                    "longitude": 151.206
                  },
                  "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36",
                  "fingerprint": "QAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolp"
                }
              })
    end

    def post_payment_again
        HTTParty.post("https://sandbox.moip.com.br/v2/orders/#{@order_id_again}/payments",
            :basic_auth => {username: $username, password: $password},
            :headers => { 'Content-Type' => 'application/json'},
            :body => {
                "installmentCount": 1,
                "statementDescriptor": "videogames",
                "fundingInstrument": {
                  "method": "CREDIT_CARD",
                  "creditCard": {
                    "id": @fundingInstrument_creditCard_id,
                    "hash": "MBQSo0e8tt4KqC7iwWtUb/Iybf56wphvkt6PI6mOB6jLFSemfabRxwZAuja+Qu0ju9A8Qqr5papxWp72tCjiCROhE+vYr6w0qr9lWQa+n5AIiUgy4OPDrYFkYX7Teow1pzAV+NDYKwuMNo34xky+AMQMUbR3z1XdwDzLZK7wtRZeW2cGSBI7GRCzFT7e+bBhmTykEo8yMgN/Lw3Z67Kl8aMEAlexGYMfrtBEraxF+X1JcuT3nGqbK3m9GlhEGPY4KLzh7qEXbpN1MuRbczzE0DcY7pUag/Cge6JbUxl3w5IyxJsBEMWKv8XlvwUKWVSk4Arh9jLM55Gfl6r+C7GfWA==",
                    "store": true,
                    "holder": {
                      "fullname": "Russel Westbrook",
                      "birthdate": "1990-10-22",
                      "taxDocument": {
                        "type": @fundingInstrument_creditCard_holder_taxDocument_type,
                        "number": "22288866644"
                      },
                      "phone": {
                        "countryCode": "55",
                        "areaCode": "11",
                        "number": "66778899"
                      }
                    }
                  }
                },
                "device": {
                  "ip": "127.0.0.1",
                  "geolocation": {
                    "latitude": -33.867,
                    "longitude": 151.206
                  },
                  "userAgent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.81 Safari/537.36",
                  "fingerprint": "QAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolpQAZXswedCVGrtgBNHyujMKIkolp"
                }
              }.to_json)
    end

end
