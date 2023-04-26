*** Settings ***
Library   SeleniumLibrary

*** Variables***
#************************** Cards
${CD_PETICIONAR}                       xpath://*[@class='card-title'][contains(text(),'Peticionar')]
${CD_PEDIDO_VISTA}                     xpath://*[@class='card-title'][contains(text(),'Pedir vista')]
${CD_PROCEDIMENTOS_VINCULADOS}         xpath://*[@class='card-title'][contains(text(),'Procedimentos')]
${CD_MEUS_PETICIONAMENTOS}             xpath://*[@class='card-title'][contains(text(),'Meus peticionamentos')]

***Keywords***

Acessar peticionamento
  Go To                               ${URL}
  Wait Until Page Contains Element    ${CD_PETICIONAR}       5
  Sleep                               4
  Click Element                       ${CD_PETICIONAR}

Acessar pedido de vista
  Go To                               ${URL}
  Wait Until Page Contains Element    ${CD_PEDIDO_VISTA}       5
  Sleep                               4
  Click Element                       ${CD_PEDIDO_VISTA}

Acessar procedimentos vinculados
  Go To                               ${URL}
  Wait Until Page Contains Element    ${CD_PROCEDIMENTOS_VINCULADOS}       5
  Sleep                               4
  Click Element                       ${CD_PROCEDIMENTOS_VINCULADOS}

Acessar meus peticionamentos
  Go To                               ${URL}
  Wait Until Page Contains Element    ${CD_MEUS_PETICIONAMENTOS}       5
  Sleep                               4
  Click Element                       ${CD_MEUS_PETICIONAMENTOS}