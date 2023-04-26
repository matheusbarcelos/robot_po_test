*** Settings ***
Resource         ${CURDIR}/../Global/Resource.robot
Suite Setup      Login
Suite Teardown   Fechar navegador

*** Test Cases ***
Efetuar download de um peticionamento
  [tags]      cenario01
  Acessar meus peticionamentos
  Buscar procedimento peticionado
  Efetuar download de documento
  Validar informacoes documento