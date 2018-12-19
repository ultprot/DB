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
    Dim userBirth
    Dim userPhone
    Dim userPass

    Dim userNumber

    userID=request.querystring("userID")
    userBirth=request.form("birthDate")
    userphone=request.form("phoneNumber")
    userPass=request.form("password")

    sqlUser="insert into 유저 (생년월일, 전화번호, 아이디, 비밀번호) values ("_
    & "'" & userBirth & "'" & ", "_
    & "'" & userPhone & "'" & ", "_
    & "'" & userID & "'" & ", "_
    & "'" & userPass & "'" & ");"

    Dbcon.Execute(sqlUser)

    sqlGetNumber="select 유저.고유번호 as 고유번호 from 유저 where 아이디="_
    & "'" & userID & "';" 

    Set Rs=Dbcon.Execute(sqlGetNumber)
    userNumber=Rs("고유번호")

    sqlNormal="insert into 사용자 (사용자_고유번호) values ("_
    & userNumber & ");"

    Dbcon.Execute(sqlNormal)

    Dbcon.Close()
    Set Dbcon=Nothing
    Set Rs=Nothing

    Response.redirect("login.html")
%>