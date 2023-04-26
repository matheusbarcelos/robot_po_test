*** Settings ***
Library   SeleniumLibrary

*** Variables***
#************************** Inputs
${IP_PROCEDIMENTO_PETICIONADO}          xpath://*[@class='input-group']//*[@placeholder="Pesquisar…"]
#************************** Botões
${BT_DOCUMENTO}                         xpath://*[@class="w-14 lg:w-20"]//label[@title="Documentos"]
${BT_DOWNLOAD_DOCUMENTO}                xpath://*[@class='btn btn-sm btn-square'][@title='Baixar Documento']
${BT_PESQUISAR_PETICIONAMENTOS}         xpath://*[@class="flex mb-2"]//button[@class="btn btn-sm btn-square"]
#************************** Textos
${TX_DOCUMENTO}                         SOLICITAÇÃO DE ATUAÇÃO (SA) Nº: 176/2022

***Keywords***

Buscar procedimento peticionado
  ${FILE}                             Load Json From File                  ${DADOS_FEITO_JSON}
  ${NUMERO_FEITO}=                    Set Variable                         ${FILE}[feito]
  Set Global Variable                 ${NUMERO_FEITO}
  Wait Until Page Contains Element    ${IP_PROCEDIMENTO_PETICIONADO}       5
  Press Keys                          ${IP_PROCEDIMENTO_PETICIONADO}       ${NUMERO_FEITO}
  Click element                       ${BT_PESQUISAR_PETICIONAMENTOS}

Efetuar download de documento
  Click element                       ${BT_DOCUMENTO}
  Wait Until Page Contains Element    ${BT_DOWNLOAD_DOCUMENTO}       5
  Click element                       ${BT_DOWNLOAD_DOCUMENTO}

Validar informacoes documento
  ${pdf_file_name}=      Wait Until Keyword Succeeds	3x	13s	 Verifica download de arquivo    ${DIRETORIO_DOWNLOAD}
      IF    '${STATUS_DOWNLOAD}' == 'True'
        ${text}=     Wait Until Keyword Succeeds		3x	10s    Get Text From Pdf    ${pdf_file_name}
         Close Pdf    ${pdf_file_name}
         ${resultado}=                     Evaluate        '${TX_DOCUMENTO}' in """${text}"""
       ELSE
         ${resultado}=    Set Variable    False    
       END
    Should Be True    ${resultado}