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

  Dim carType
  carType=request.form("type")
  Dim carNumber
  carNumber=request.form("number")

  userID=session.contents("userID")
  userNumber=session.contents("userNumber")
  
  sql="insert into 차량 (차량번호, 차종, 고유번호) "_
  & "values(" & carNumber & ", '" & carType & "'," & userNumber & ");"

  Set Rs=Dbcon.Execute(sql)

  Response.redirect("myCar.asp")

  Dbcon.Close()
  Set Dbcon=Nothing
  Set Rs=Nothing
%>