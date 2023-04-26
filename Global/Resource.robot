*** Settings ***
Library   DebugLibrary
Library   SeleniumLibrary
Library   JSONLibrary
Library   String
Library   ScreenCapLibrary
Library     OperatingSystem
Library     RPA.PDF

Resource  ${CURDIR}/../Pages/HomePage.robot
Resource  ${CURDIR}/../Pages/PeticionarPage.robot
Resource  ${CURDIR}/../Pages/PedidoVistaPage.robot
Resource  ${CURDIR}/../Pages/ProcedimentosVinculadosPage.robot
Resource  ${CURDIR}/../Pages/HistoricoPeticionamentoPage.robot

*** Variables***
#************************** Url
${URL}                      http://matrix-des.mpmg.mp.br:3000/
${BROWSER}                  chrome
${BROWSER_HEADLESS}         headlesschrome
#************************** Diretorio
${DIRETORIO_DOWNLOAD}       ${OUTPUT DIR}${/}downloads_temporarios
#************************** Arquivos
${LOGIN_JSON}               ${CURDIR}/../Fixtures/Json/Login.json
#************************* ELEMENTOS DAS PAGINAS  ******************************
#************************** Botões
${BT_ENTRAR}                xpath://*[@href="/sigin"]
${BT_CONTINUAR_LOGIN}       xpath://*[@id="login-button-panel"]//*[@value='enterAccountId']
${BT_ENTRAR_LOGIN}          id:submit-button
#************************** Inputs
${IP_CPF}                   id:accountId
${IP_SENHA}                 id:password
#************************** Textos
${TX_HOME_PROMOTORIA}       xpath://*[@class='text-xl'][contains(text(),'Seja bem vindo à Promotoria Online!')]
#************************** Cookie
${JWT}                      eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjcGYiOiIxMjAyNDk5MTYzNyIsIm5hbWUiOiJNZXUgTm9tZSIsImVtYWlsIjoibWJhcmNlbG9zQG1wbWcubXAuYnIiLCJwaG9uZV9udW1iZXIiOiIzNzk5ODQxNjgwMyIsInNlbG8iOnsiaWQiOiIxIiwiZGF0YUF0dWFsaXphY2FvIjoiMjAyMy0wNC0wNFQwNzo0NDowNC42NTYtMDMwMCIsIm5hbWUiOiJCcm9uemUifSwiaWF0IjoxNjgxMzI5ODk1LCJleHAiOjE2ODE0MTYyOTV9.wjzRmHmSAtaxNAF8_epl5YICFTlv1oWsu1lkrmn5Eoc

***Keywords***
Login
  Criar diretorio para download       ${DIRETORIO_DOWNLOAD}
  Configurar Chrome
  Start Video Recording               alias=None      name=RobotRecording      fps=None    size_percentage=1       embed=True      embed_width=100px        
  Go To                               ${URL}    
  Maximize Browser Window
  Wait Until Page Contains Element    ${BT_ENTRAR}             5
  Click Element                       ${BT_ENTRAR} 
  Obter informações de login
  Input Text                          ${IP_CPF}                ${CPF}
  Click Button                        ${BT_CONTINUAR_LOGIN}
  Input Text                          ${IP_SENHA}              ${SENHA}
  Click Button                        ${BT_ENTRAR_LOGIN}
  Wait Until Page Contains Element    ${TX_HOME_PROMOTORIA}    15        

Fechar navegador
  Excluir arquivos baixados           ${DIRETORIO_DOWNLOAD}      
  Excluir diretorio download          ${DIRETORIO_DOWNLOAD}
  Run Keyword And Ignore Error        Stop Video Recording                alias=None
  Capture Page Screenshot
  Close Browser

Obter informações de login
  ${FILE}                 Load Json From File     ${LOGIN_JSON}
  ${CPF}=                 Set Variable            ${FILE}[cpf]
  ${SENHA}=               Set Variable            ${FILE}[senha]   
  Set Global Variable     ${CPF}
  Set Global Variable     ${SENHA}

Criar diretorio para download
    [Arguments]    ${diretorio}
    ${STATUS}   ${TEXTO_JSON}=      Run Keyword And Ignore Error    Join Path    Directory Should Not Exist    ${diretorio}
    Run Keyword If      '${STATUS}' == 'PASS'    Run Keyword And Ignore Error    Create Directory    ${diretorio}

Configurar Chrome
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    ${excluded}           Create List         enable-logging
    ${preferencias}       Create Dictionary   download.default_directory=${DIRETORIO_DOWNLOAD}
    Call Method           ${chrome options}    add_experimental_option    prefs    ${preferencias}
    Call Method           ${chrome_options}    add_argument               --ignore-certificate-errors
    Call Method           ${chrome_options}    add_argument               --PageLoadStrategy.EAGER
    Call Method           ${chrome_options}    add_argument               --disable-extensions
    Call Method           ${chrome_options}    add_experimental_option    excludeSwitches          ${excluded}
    Call Method           ${chrome_options}    add_argument               --disable-gpu
    Call Method           ${chrome_options}    add_argument               --no-sandbox
    ${options}=           Call Method          ${chrome_options}          to_capabilities
    Create Webdriver      Chrome    chrome_options=${chrome options}

Excluir arquivos baixados
    [Arguments]    ${diretorio}
    @{files}    Run Keyword And Ignore Error        List Files In Directory    ${diretorio}
    ${length}=    Get Length    ${files}[1]
    FOR     ${i}    IN RANGE    ${length}
        Run Keyword And Ignore Error     Remove File         ${diretorio}${/}${files}[1][${i}]
    END

Excluir diretorio download
    [Arguments]    ${diretorio}
    ${STATUS}   ${TEXTO_JSON}=   Run Keyword And Ignore Error     Directory Should Exist    ${diretorio}
    Run Keyword If      '${STATUS}' == 'PASS'    Run Keyword And Ignore Error        Remove Directory    ${diretorio}

Verifica download de arquivo
    [Arguments]    ${diretorio}
    FOR     ${i}    IN RANGE    3
        ${arquivos}    List Files In Directory    ${diretorio}
        Run Keyword And Ignore Error    Length Should Be    ${arquivos}    1    Deve haver apenas um arquivo na pasta de download
        ${STATUS}   ${FILE}=      Run Keyword And Ignore Error    Should Not Match Regexp    ${arquivos[0]}    (?i).*\\.tmp    Chrome is still downloading a file
        IF     '${STATUS}' == 'PASS'
            Exit For Loop
        ELSE
            Sleep   ${ESPERA_LOADING}
        END
    END
    FOR     ${i}    IN RANGE    3
        ${arquivos}    List Files In Directory    ${diretorio}
        Run Keyword And Ignore Error    Length Should Be    ${arquivos}    1    Deve haver apenas um arquivo na pasta de download
        ${STATUS}   ${FILE}=      Run Keyword And Ignore Error    Should Not Match Regexp    ${arquivos[0]}    (?i).*\\.crdownload    Chrome is still downloading a file
        IF     '${STATUS}' == 'PASS'
            Exit For Loop
        ELSE
            Sleep   ${ESPERA_LOADING}
        END
    END
    FOR     ${i}    IN RANGE    3
        ${STATUS}   ${arquivo}=    Run Keyword And Ignore Error    Join Path    ${diretorio}    ${arquivos[0]}
        IF     '${STATUS}' == 'PASS'
            Exit For Loop
        ELSE
            Sleep   ${ESPERA_LOADING}
        END
    END
    IF      '${STATUS}' == 'PASS'
        ${STATUS_DOWNLOAD}=     set variable    True
        Set Global Variable     ${STATUS_DOWNLOAD}
    ELSE
        Go To                   ${URL}
        ${arquivo}=    Set Variable    None
        ${arquivo}=    Set Variable    ${EMPTY}
        ${STATUS_DOWNLOAD}=     set variable    Fail
        Set Global Variable     ${STATUS_DOWNLOAD}
    END
    [Return]    ${arquivo}


Inserir Cookie no Browser
  Add Cookie                          jwt                     ${JWT}          path=/     domain=matrix-des.mpmg.mp.br
  Go To                               ${URL}