*** Settings ***
Resource         ${CURDIR}/../Global/Resource.robot
Suite Setup      Login
Suite Teardown   Fechar navegador
Test Teardown    Evidencias

*** Test Cases ***

Efetuar download de um peticionamento
  [tags]      cenario01
  Acessar meus peticionamentos
  Buscar procedimento peticionado
  Efetuar download de documento
  Validar informacoes documento

Pedido de Vista em análise
  [tags]      cenario02
  Acessar pedido de vista
  Preencher feito pedido de vista
  Validar pedido em análise

Efetuar um peticionamento válido
  [tags]      cenario03
  Acessar Peticionamento
  Preencher Feito Peticionamento
  Upload Documento
  Confirmar Peticionamento
  Validar Peticionamento

Consultar informações de um procedimento vinculado
  [tags]      cenario04
  Acessar procedimentos vinculados
  Preencher procedimento vinculado

