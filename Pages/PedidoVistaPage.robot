*** Settings ***
Library   SeleniumLibrary

*** Variables***
#************************** Arquivos
${DADOS_FEITO_JSON}               ${CURDIR}/../Fixtures/Json/Dados_Feito.json
#************************** Inputs
${IP_FEITO_PEDIDO_VISTA}          xpath://*[@name="numero"][@placeholder='Número do procedimento']
#************************** Textos
${TX_PEDIDO_EM_ANALISE}           Você já tem um pedido de vista para esse procedimento em análise!
#************************** Notificações
${NT_PEDIDO_VISTA}                xpath://*[@class="alert alert-warning shadow-lg"]
#************************** Botões
${BT_BUSCAR}                      css:.card-actions > .btn


***Keywords***
Preencher feito pedido de vista
  ${FILE}                             Load Json From File            ${DADOS_FEITO_JSON}
  ${NUMERO_FEITO}=                    Set Variable                   ${FILE}[feito]
  Set Global Variable                 ${NUMERO_FEITO}
  Wait Until Page Contains Element    ${IP_FEITO_PEDIDO_VISTA}       5
  Press Keys                          ${IP_FEITO_PEDIDO_VISTA}       ${NUMERO_FEITO}
  Click Element                       ${BT_BUSCAR}

Validar pedido em análise
  Wait Until Page Contains Element    ${NT_PEDIDO_VISTA}             5 
  ${STATUS_PEDIDO_VISTA}=             Get Text                       ${NT_PEDIDO_VISTA} 
  Should Be Equal                     ${STATUS_PEDIDO_VISTA}         ${TX_PEDIDO_EM_ANALISE}

  