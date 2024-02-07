#include 'totvs.ch'
#include 'TopConn.ch'

/*/{Protheus.doc} RELATORIO
(long_description)
@type user function
@author user
@since 06/02/2024
@version 1.0
/*/
User Function RELATORIO()
   
    Local oReport 
    Local cAlias := getNextAlias()

    oReport := RptStruc(cAlias)

    oReport:printDialog()

Return

Static Function rPrint(cReport,cAlias)

    Local oSecao1 := cReport:Section(1)

    oSecao1:BeginQuery()

        BeginSql Alias cAlias       
                SELECT ZA1_CODIGO, ZA1_NOME, ZA1_IDADE, ZA1_DTNAS
                FROM %table:ZA1% ZA1
                WHERE ZA1.D_E_L_E_T_ = ' '

                ORDER BY ZA1_CODIGO
        EndSql
        
    oSecao1:EndQuery()
    oSecao1:SetMeter((cAlias)->(RecCount()))
    oSecao1:Print()
Return


Static Function RptStruc(cAlias)
    
    Local cTitulo := "Pessoas Ativas"
    Local cHelp := "Permite imprimir relatórios de pessoas"
    Local oReport
    Local oSection1

    //
    oReport := TReport():New('TRPT001',cTitulo,/*Pergunta*/,{|oReport|rPrint(oReport, cAlias)},cHelp)

    //

    oSection1 := TRSection():New(oReport, "Pessoas",{cAlias})

    TRCell():New(oSection1, "ZA1_CODIGO", cAlias, "CÓDIGO")
    TRCell():New(oSection1, "ZA1_NOME", cAlias, "NOME")
    TRCell():New(oSection1, "ZA1_IDADE", cAlias, "IDADE")
    TRCell():New(oSection1, "ZA1_DTNAS", cAlias, "DATA DE NASCIMENTO")

Return (oReport)    
