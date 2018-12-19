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
  Dim userID
  Dim userNumber

  Dim carNumber
  carNumber=request.querystring("carNumber")

  userID=session.contents("userID")
  userNumber=session.contents("userNumber")
  
  sql="delete from 차량 where "_
  & "고유번호=" & userNumber & " and " _
  & "차량번호=" & carNumber & ";"

  Set Rs=Dbcon.Execute(sql)

  Response.redirect("myCar.asp")
  Dbcon.Close()
  Set Dbcon=Nothing
  Set Rs=Nothing
%>