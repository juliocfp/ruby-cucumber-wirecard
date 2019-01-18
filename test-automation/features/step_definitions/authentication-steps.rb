# encoding: utf-8

auth = Authentication.new

Dado("que eu tenha acesso autorizado na api") do
    auth.set_authentication_valid
end

Dado("que eu não tenha acesso autorizado na api") do
    auth.set_authentication_invalid
end