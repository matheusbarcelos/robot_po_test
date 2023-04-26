*** Settings ***
Resource         ${CURDIR}/../Global/Resource.robot
Suite Setup      Login
Suite Teardown   Fechar navegador

*** Test Cases ***
Efetuar um peticionamento válido
  [tags]      cenario01
  Acessar Peticionamento
  Preencher Feito Peticionamento
  Upload Documento
  Confirmar Peticionamento
  Validar Peticionamento