*** Settings ***
Resource         ${CURDIR}/../Global/Resource.robot
Suite Setup      Login
Suite Teardown   Fechar navegador

*** Test Cases ***
Pedido de Vista em análise
  [tags]      cenario01
  Acessar pedido de vista
  Preencher feito pedido de vista
  Validar pedido em análise