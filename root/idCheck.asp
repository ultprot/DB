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

    inputID=request.form("userID")
    
    sql="select * from 유저 where 아이디=" & inputID

    Set Rs=Dbcon.Execute(sql)

    if Rs.BOF then
        Dbcon.Close()
        Set Dbcon=Nothing
        Set Rs=Nothing
        Dim goto
        goto="register.asp?inputID=" & inputID
        response.redirect(goto)
    else
        session("userID")=userID
        session("userNumber")=Rs("유저")
        if IsNull(Rs("관리자")) then
            session("isManager")=False
        else
            session("isManager")=True
        end if

        if IsNull(Rs("소유자")) then
            session("isOwner")=False
        else
            session("isOwner")=True
        end if

        if IsNull(Rs("사용자")) then
            session("isNormal")=False
        else
            session("isNormal")=True
        end if

        Dbcon.Close()
        Set Dbcon=Nothing
        Set Rs=Nothing
        Server.Execute("userInfo.asp")
    end if
%>
