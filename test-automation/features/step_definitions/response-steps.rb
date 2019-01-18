# encoding: utf-8

Então("a mensagem exibirá o atributo {string} com valor {string}") do |type, value|
    validation = "\"#{type}\":\"#{value}\""
    puts validation
    expect(@response.body).to include(validation)
end

Então("a mensagem {string} será exibida") do |message|
    puts @response.body
    expect(@response.body.force_encoding("utf-8")).to include(message)
end
