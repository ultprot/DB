<%@Language="VBScript" CODEPAGE="65001"%>
<%
    Response.CharSet="utf-8"
    Session.codepage="65001"
    Response.codepage="65001"
    Response.ContentType="text/html;charset=utf-8"
%>
<%
    Set Dbcon=Server.CreateObject("ADODB.Connection")
    Dbcon.Open Application("dbConnect")

    Dim userNumber
    Dim account

    userNumber=session("userNumber")
    account=request.form("Account")

    sql="insert into 소유자 (계좌, 소유자_고유번호) values ('"_
    & account & "', "_
    & userNumber & ");"

    Dbcon.Execute(sql)

    Dbcon.Close()
    Set Dbcon=Nothing
    Set Rs=Nothing

    session("isOwner")=true

    Response.redirect("userInfo.asp")
%>