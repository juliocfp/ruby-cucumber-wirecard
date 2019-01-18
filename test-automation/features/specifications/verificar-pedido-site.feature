#language: pt

@site
Funcionalidade: informações do pedido

    Cenário: informações do pedido no site
        Dado que eu tenha um pedido realizado e pago
        Quando logar na minha conta da wirecard
        Então as informçãoes do pedido devem ser exibidas corretamente