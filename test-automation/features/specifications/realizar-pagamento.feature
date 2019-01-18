#language: pt

@paymentAPI
Funcionalidade: realizar pagamento

    @paymentInAnalysis
    Cenário: pagamento em análise
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de pagamento válida
        Então a resposta terá status 201
        E a mensagem exibirá o atributo "status" com valor "IN_ANALYSIS"

    @paymentAuthorized
    Cenário: pagamento aprovado
        Dado que eu tenha acesso autorizado na api
        Quando consultar um pagamento realizado
        Então a resposta terá status 200
        E a mensagem exibirá o atributo "status" com valor "AUTHORIZED"

    @paymentSameOrder
    Cenário: pagar o mesmo pedido mais de uma vez
        Dado que eu tenha um pedido pago
        Quando enviar novamente a requisição de pagamento
        Então a resposta terá status 400
        E a mensagem "O pedido já foi pago" será exibida

    @paymentInvalidStructure
    Cenário: estrutura JSON inválida
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de pagamento com estrutura inválida
        Então a resposta terá status 400
        E a mensagem "Estrutura de JSON inválida" será exibida

    @paymentErrorRequiredField
    Esquema do Cenário: atributos obrigatórios
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de pagamento sem o atributo "<var>"
        Então a resposta terá status 400
        E a mensagem "<message>" será exibida

        Exemplos:
        | var           | message                                  |
        | creditCard_id | Cartão de crédito não foi encontrado     |
        | documentType  | O tipo de documento informado é inválido |

    @paymentErrorUnauthorized
    Cenário: acesso não autorizado
        Dado que eu não tenha acesso autorizado na api
        Quando enviar uma requisição de pagamento válida
        Então a resposta terá status 401
        E a mensagem "Token or Key are invalids" será exibida
