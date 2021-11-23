*** Settings ***
Library             RequestsLibrary
Library             Collections

*** Variables ***
${URL_API}             https://fakerestapi.azurewebsites.net/api/v1
&{BOOK_15}             id=15
...                    title=Book 15
...                    pageCount=1500


*** Keywords ****
###SETUP E TEARDOWNS
Conectar a minha API
    Create Session      v1     ${URL_API}


### Ações
Requisitar todos os livros
    ${RESPOSTA}     Get Request         v1     Books
    Log                         ${RESPOSTA.text}
    Set Test Variable           ${RESPOSTA}

Requisitar o livro "${ID_LIVRO}"
    ${RESPOSTA}    Get Request        v1        Books/${ID_LIVRO}
    Log                         ${RESPOSTA.text}
    Set Test Variable           ${RESPOSTA}

#Conferencias
Validar se retornou o status code
    [Arguments]                     ${STATUSCODE_DESEJADO}
    Should Be Equal As Strings       ${RESPOSTA.status_code}     ${STATUSCODE_DESEJADO}

Validar se retornou o reason
    [Arguments]     ${REASON_DESEJADO}
    Should Be Equal As Strings     ${RESPOSTA.reason}          ${REASON_DESEJADO}

Validar se retornou o uma lista com "${QTDE_LIVROS}" livros
    Length Should Be        ${RESPOSTA.json()}          ${QTDE_LIVROS}

Validar se retornou os dados correto do livro
    Dictionary Should Contain Item    ${RESPOSTA.json()}    id                    ${BOOK_15.id}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    title                 ${BOOK_15.title}
    Dictionary Should Contain Item    ${RESPOSTA.json()}    pageCount             ${BOOK_15.pageCount}
    Should Not Be Empty               ${RESPOSTA.json()["description"]}    
    Should Not Be Empty               ${RESPOSTA.json()["excerpt"]}    