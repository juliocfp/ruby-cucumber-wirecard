# encoding: utf-8

wirecard = Wirecard.new

Quando("logar na minha conta da wirecard") do
    visit "https://connect-sandbox.moip.com.br"
    wirecard.login
end

Então("as informçãoes do pedido devem ser exibidas corretamente") do
    puts wirecard.return_own_id
    puts wirecard.return_customer_name
    puts wirecard.return_amount
    expect(wirecard.return_own_id).to include(@own_id)
    expect(wirecard.return_customer_name).to include(@customer_name.downcase)
    amount = @amount.to_s
    amount.to_s.insert -3, ','
    amount.to_s.insert 0, 'R$ '
    expect(wirecard.return_amount).to include(amount)
end
