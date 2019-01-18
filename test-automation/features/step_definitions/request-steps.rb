# encoding: utf-8

auth = Authentication.new
order = Order.new
payment = Payment.new

Dado("que eu tenha um pedido pago") do
    auth.set_authentication_valid
    payment.set_valid_request_payment
    payment.post_payment
end

Dado("que eu tenha um pedido realizado e pago") do
    auth.set_authentication_valid
    order.set_valid_request
    payment.set_valid_request_payment
    id = order.return_order_id(order.post_order.body)
    payment.post_payment_especific(id)
    json_order = order.get_order id
    @own_id = payment.return_payment_own_id(json_order.body.force_encoding("utf-8"))
    puts @own_id
    @customer_name = payment.return_payment_customer_name(json_order.body.force_encoding("utf-8"))
    puts @customer_name
    @amount = payment.return_payment_amount(json_order.body.force_encoding("utf-8"))
    puts @amount
end

Quando("enviar uma requisição de pedido válida") do
    order.set_valid_request
    @response = order.post_order
end

Quando("enviar uma requisição de consulta de pedido válida") do
    order.set_valid_request
    id = order.return_order_id(order.post_order.body)
    puts id
    @response = order.get_order id
end

Quando("enviar uma requisição de consulta de pedido inválida") do
    @response = order.get_order "ragnarok"
end

Quando("enviar uma requisição de pedido com estrutura inválida") do
    order.set_valid_request
    @response = order.post_invalid_structure_order
end

Quando("enviar uma requisição de pedido sem o atributo {string}") do |type|
    order.set_invalid_request type
    @response = order.post_order
    puts @response.body
end

Quando("enviar uma requisição de pagamento válida") do
    payment.set_valid_request_payment
    @response = payment.post_payment
end

Quando("consultar um pagamento realizado") do
    payment.set_valid_request_payment
    id = payment.return_order_id(payment.post_payment.body)
    puts id
    sleep(1)
    @response = payment.get_payment id
end

Quando("enviar novamente a requisição de pagamento") do
    @response = payment.post_payment_again
end

Quando("enviar uma requisição de pagamento com estrutura inválida") do
    payment.set_valid_request_payment
    @response = payment.post_invalid_structure_payment
end

Quando("enviar uma requisição de pagamento sem o atributo {string}") do |type|
    payment.set_invalid_request_payment type
    @response = payment.post_payment
    puts @response.body
end
