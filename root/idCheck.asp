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
    Dim inputID
    Dim dir
    
    inputID=request.form("userID")
    
    sql="select * from 유저 where 아이디='" & inputID & "';"

    Set Rs=Dbcon.Execute(sql)

    if Rs.BOF then
        Dbcon.Close()
        Set Dbcon=Nothing
        Set Rs=Nothing
        dir="register.asp?inputID=" & inputID
        response.redirect(dir)
    else
        Dbcon.Close()
        Set Dbcon=Nothing
        Set Rs=Nothing
        response.write("이미 존재 하는 아이디입니다.")
    end if
%>
