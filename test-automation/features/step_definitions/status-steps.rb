# encoding: utf-8

Então("a resposta terá status {int}") do |status_code|
    puts @response.code
    expect(@response.code).to eq status_code
end
