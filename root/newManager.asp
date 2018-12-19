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

    userNumber=session("userNumber")

    sql="insert into 관리자 (근무_시작시간, 근무_종료시간, 근무_시작기간, 근무_종료기간, 관리자_고유번호) values (null,null,"_
    & "getdate()" & ", "_
    & "null" & ", "_
    & userNumber & ");"

    Dbcon.Execute(sql)

    Dbcon.Close()
    Set Dbcon=Nothing
    Set Rs=Nothing

    session("isManager")=true

    Response.redirect("userInfo.asp")
%>