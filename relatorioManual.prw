#include 'totvs.ch'

/*/{Protheus.doc} RELATORIOMAN
(long_description)
@type user function
@author Aencio Vinicius
@since 07/02/2024
@version 1.0
    @see https://tdn.totvs.com/display/tec/FCreate
    @see https://tdn.totvs.com/display/tec/FWrite
    @see https://tdn.totvs.com/display/tec/FError
    @see https://tdn.totvs.com/display/tec/FClose
    @see https://tdn.totvs.com/display/tec/File
    @see https://tdn.totvs.com/display/tec/FErase
/*/
User Function TESTEDERELA()

    Local cSaveFile
    Local cBuffer
    Local nHandle
    Local nBuffer
    Local nWrite
    
    // area de trabalho a ser utilizada
    rpcSetEnv("99", "01")
    
    // cria o atalho do arquivo 
    cSaveFile := 'C:\TOTVS12\arquivoManual.txt'

    // verifica se o arquivo existe
    IF File(cSaveFile)
        // se sim, deleta o arquivo 
        fErase(cSaveFile)
    EndIF

    // cria o arquivo
    nHandle := fCreate(cSaveFile)

    // se p handle for menor que 0, ocorreu algum erro ao criar o arquivo.
    IF nHandle < 0
        //Alerta o erro que ocorreu e mostra o codigo
        fwAlertError("Erro ao efetuar a criação do arquivo. Código do erro: " + Str(fError(),4), "ERRO")
        // fecha a area de trabalho
        rpcClearEnv()
        Return .F.
    EndIF

    //cBuffer := padr("CODIGO",8) + "-" + padr("NOME COMPLETO", 15) + "-" + padr("IDADE",7) + "-" + padr("DATA DE NASCIMENTO", 20)
    //nBuffer := len(cBuffer)

   // nWrite := fWrite(nHandle, cBuffer)

    
    cBuffer := padr("CODIGO",10) + "-" + padr(" NOME",8) + "-" + padr(" IDADE",6) + padr(" NOME COMPLETO",30) + "-" + padr("DT NASCIMENTO", 30)
    nBuffer := Len(cBuffer)

    nWrite := fWrite(nHandle,cBuffer)

    IF nWrite <> nBuffer 
        //Alerta o erro que o correu e mostra o codigo
        fwAlertError("Erro ao efetuar a gravação do arquivo. Código do erro: " + Str(fError(),4), "ERRO")
        fClose(nHandle)
        // fecha a area de trabalho
        rpcClearEnv()
    EndIF

    cBuffer := CRLF + strtran(space(70)," ", "-")
    nBuffer := len(cBuffer)

    nWrite := FWrite(nHandle, cBuffer)

    IF nWrite <> nBuffer 
        fwAlertError("Erro ao efetuar a gravação no arquivo. Código do erro: " + Str(fError(),4), "ERRO")
        fClose(nHandle)
        rpcClearEnv()
    EndIF

    dBloco := {|| cBuffer := CRLF +;
                             padr(alias(),10) + "-" +;
                             padr(ZA1_CODIGO,10) + "-" +; 
                             padr(ZA1_NOME,8) + "-" +; 
                             padr(ZA1_IDADE,6) + "-"+;
                             padr(LEFT(ZA1_DESC,30),30) + "-" +;
                             padr(dtoc(ZA1_DTNAS), 30),;
                             fWrite(nHandle, cBuffer)}
    ZA1->(DBEval(dBloco))

    fClose(nHandle)

    // fecha a area de trabalho
    rpcClearEnv()

Return
