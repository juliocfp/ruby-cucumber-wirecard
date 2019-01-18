#language: pt

@orderAPI
Funcionalidade: realizar pedido

    @orderSuccess
    Cenário: pedido realizado com sucesso
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de pedido válida
        Então a resposta terá status 201
        E a mensagem exibirá o atributo "status" com valor "CREATED"

    @orderReadExistent
    Cenário: consultar pedido existente
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de consulta de pedido válida
        Então a resposta terá status 200
        E a mensagem exibirá o atributo "status" com valor "CREATED"

    @orderReadNonExistent
    Cenário: consultar pedido não existente
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de consulta de pedido inválida
        Então a resposta terá status 404
        E a mensagem "Not Found" será exibida

    @orderInvalidStructure
    Cenário: estrutura JSON inválida
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de pedido com estrutura inválida
        Então a resposta terá status 400
        E a mensagem "Estrutura de JSON inválida" será exibida

    @orderErrorRequiredField
    Esquema do Cenário: atributos obrigatórios
        Dado que eu tenha acesso autorizado na api
        Quando enviar uma requisição de pedido sem o atributo "<var>"
        Então a resposta terá status 400
        E a mensagem "<message>" será exibida

        Exemplos:
        | var      | message                                         |
        | ownId    | É necessario informar seu identificador próprio |
        | items    | Categoria informada não é válida                |
        | customer | O identificador próprio não foi informado       |

    @orderErrorUnauthorized
    Cenário: acesso não autorizado
        Dado que eu não tenha acesso autorizado na api
        Quando enviar uma requisição de pedido válida
        Então a resposta terá status 401
        E a mensagem "Token or Key are invalids" será exibida
