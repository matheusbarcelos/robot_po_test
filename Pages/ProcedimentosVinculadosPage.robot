*** Settings ***
Library   SeleniumLibrary

*** Variables***
#************************** Inputs
${IP_PROCEDIMENTO_VINCULADO}          css:.input-group > .input
#************************** Grid
${GR_PROCEDIMENTO_VINCULADO}          css:tbody > tr > :nth-child(3)
#************************** Pesquisa
${IP_BUSCA}                           xpath://*[@class="input-group"]//button[@class="btn btn-sm btn-square"]


***Keywords***

Preencher procedimento vinculado
  ${FILE}                             Load Json From File            ${DADOS_FEITO_JSON}
  ${NUMERO_FEITO}=                    Set Variable                   ${FILE}[feito_vinculado]
  Set Global Variable                 ${NUMERO_FEITO}
  Wait Until Page Contains Element    ${IP_PROCEDIMENTO_VINCULADO}   5
  Press Keys                          ${IP_PROCEDIMENTO_VINCULADO}   ${NUMERO_FEITO}
  Click Element                       ${IP_BUSCA}   
  ${CLASSE_PROCEDIMENTO}=             Get Text                       ${GR_PROCEDIMENTO_VINCULADO}
  Should Be Equal                     ${CLASSE_PROCEDIMENTO}         Inquérito Civil