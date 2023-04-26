*** Settings ***
Library   SeleniumLibrary

*** Variables***
#************************** Arquivos
${DADOS_FEITO_JSON}               ${CURDIR}/../Fixtures/Json/Dados_Feito.json
${DOCUMENTO_PETICIONAMENTO}       ${CURDIR}${/}Documentos/doc.pdf
#************************** Textos
${TX_PAGINA_PETICIONAR}          Favor informar o número do procedimento no campo ao lado.
${TX_DOCUMENTOS_PETICIONAR}      Adicionar documento(s)
${TX_PETICIONAMENTO_SUCESSO}     Petição realizada com sucesso.
#************************** Inputs
${IP_FEITO_PETICIONAR}           xpath://*[@name="numero"]
${IP_DOCUMENTO_PETICIONAR}       xpath://input[@type="file"]
#************************** Check-Box
${CB_PETICIONAR}                 css:.checkbox
#************************** Botões
${BT_PETICIONAR}                 xpath://button [@type='submit']
${BT_CONFIRMAR_PETICIONAMENTO}   css:.bx--modal-footer > .bx--btn--primary
${BT_BUSCAR_FEITO}               css:.card-actions > .btn
#************************** Grid
${GR_FEITO_PETICIONADO}          xpath://*[@id="main-content"]//tbody//tr[1]
 

***Keywords***
Preencher feito peticionamento
  ${FILE}                             Load Json From File            ${DADOS_FEITO_JSON}
  ${NUMERO_FEITO}=                    Set Variable                   ${FILE}[feito]
  Set Global Variable                 ${NUMERO_FEITO}
  Wait Until Page Contains Element    ${IP_FEITO_PETICIONAR}         5
  Press Keys                          ${IP_FEITO_PETICIONAR}         ${NUMERO_FEITO}
  Click Element                       ${BT_BUSCAR_FEITO}
  Wait Until Page Contains            ${TX_DOCUMENTOS_PETICIONAR}    5

Upload documento
  Choose File          ${IP_DOCUMENTO_PETICIONAR}     ${DOCUMENTO_PETICIONAMENTO}
  
Confirmar peticionamento      
  Click Element               ${CB_PETICIONAR}
  Click Button                ${BT_PETICIONAR}

Validar peticionamento
  Wait Until Page Contains           ${TX_PETICIONAMENTO_SUCESSO}
  # Wait Until Page Contains Element   ${GR_FEITO_PETICIONADO}         5
  # ${DADOS_GRID}                      Get Text                        ${GR_FEITO_PETICIONADO}
  # Should Contain                     ${DADOS_GRID}                   doc.pdf
  Capture Page Screenshot