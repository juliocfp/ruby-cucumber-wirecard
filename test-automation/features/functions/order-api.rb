class Order
    def get_order(order_id)
        HTTParty.get("https://sandbox.moip.com.br/v2/orders/#{order_id}",
            :basic_auth => {username: $username, password: $password})
    end

    def return_order_id(json_string)
        parsed_json = JSON.parse(json_string)
        parsed_json['id']
    end

    def set_valid_request
        @own_id = Random.rand(1...999999)
        @amount_currency = "BRL"
        @subtotals_shipping = 500
        @items_product = "Counter-Strike"
        @items_category = "VIDEO_GAME_SOFTWARE"
        @items_quantity = 1
        @items_detail = "Jogo para PC"
        @items_price = 88500
        @customer_id = "CUS-7I1IM7A15A5Z"
    end

    def set_invalid_request(type)
        set_valid_request
        case type
        when "ownId"
            @own_id = ""
        when "items"
            @items_category = ""
        when "customer"
            @customer_id = ""
        else
            puts "valor para troca não encontrado"
        end
    end

    def post_order
        HTTParty.post("https://sandbox.moip.com.br/v2/orders/",
            :basic_auth => {username: $username, password: $password},
            :headers => { 'Content-Type' => 'application/json'},
            :body => { "ownId": @own_id, "amount": {"currency": @amount_currency, "subtotals": {"shipping": @subtotals_shipping}},
                        "items": [{"product": @items_product, "category": @items_category, "quantity": @items_quantity, "detail": @items_detail,
                        "price": @items_price}], "customer": {"id": @customer_id} }.to_json)
    end

    def post_invalid_structure_order
        HTTParty.post("https://sandbox.moip.com.br/v2/orders/",
            :basic_auth => {username: $username, password: $password},
            :headers => { 'Content-Type' => 'application/json'},
            :body => { "ownId": @own_id, "amount": {"currency": @amount_currency, "subtotals": {"shipping": @subtotals_shipping}},
                        "items": [{"product": @items_product, "category": @items_category, "quantity": @items_quantity, "detail": @items_detail,
                        "price": @items_price}], "customer": {"id": @customer_id} })
    end
end
