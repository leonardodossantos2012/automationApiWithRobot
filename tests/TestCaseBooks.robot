*** Settings ***
Documentation       Documentação da API:    https://fakerestapi.azurewebsites.net/api/v1/Books
Resource            ../resource/ResourceAPI.robot
Suite Setup         Conectar a minha API


*** Test Cases ***
Buscar a listagem de todos os livros (GET em todos os livros)
    Requisitar todos os livros
    Validar se retornou o status code  200
    Validar se retornou o reason  OK
    Validar se retornou o uma lista com "200" livros

Buscar um livro especifico (GET em um livro especifico)
    Requisitar o livro "15"
    Validar se retornou o status code  200
    Validar se retornou o reason  OK
    Validar se retornou os dados correto do livro