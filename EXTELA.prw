#include 'totvs.ch'

/*/{Protheus.doc} TELAZA1
(Essa função cria uma tela de teste para cadastro de pessoas(ZA1))
@type user function
@author Aencio Vinicius
@since 01/02/2024
@version 1.0
@see (links_or_references)  

/DESAFIO
tabela customizada -> ZA1(pessoas): codigo, descrição, peso(2casas)
tela para descrição do cadastro (mbrowse e axcadastro)
relatorio com o que for incluso.
campos da tabela: ZA1_COD, ZA1_DESC, ZA1_PESO, ZA1_NOME, ZA1_DTNASC, ZA1_IDADE

;botão do relatório dentro da tabela
deixar o relatório(buttom) dentro da tela
/*/

User Function EXTELA()

    Local cAlias := "ZA1"

    Private cCadastro := "Cadastro de Pessoas"
    Private aRotina   := {}


    //O ultimo numero controla o tipo da operação da função.
    AAdd(aRotina, {"Pesquisar" , "AxPesqui", 0,1}) // 1 = Pesquisa
    AAdd(aRotina, {"Visualizar", "AxVisual", 0,2}) // 2 = visualizar
    AAdd(aRotina, {"Incluir"   , "AxInclui", 0,3}) // 3 = incluir 
    AAdd(aRotina, {"Alterar"   , "AxAltera", 0,4}) // 4 = Alterar
    AAdd(aRotina, {"Exclui"    , "AxDeleta", 0,5}) // 5 = Excluir
    AAdd(aRotina, {"Relatorio" , "U_RELATORIO()",0,6})

DBSelectArea(cAlias)
DBSetOrder(1)

// 6 = linha 1, 1 = coluna 1, 22 = linha 2, 75 = coluna 2 ou final 
mbrowse(6, 1, 22, 75, cAlias)

Return Nil
