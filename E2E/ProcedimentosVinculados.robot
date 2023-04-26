*** Settings ***
Resource         ${CURDIR}/../Global/Resource.robot
Suite Setup      Login
Suite Teardown   Fechar navegador

*** Test Cases ***
Consultar informações de um procedimento vinculado
  [tags]      cenario01
  Acessar procedimentos vinculados
  Preencher procedimento vinculado