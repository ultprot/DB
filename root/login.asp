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
    Dim userPassword

    userID=request.form("userID")
    userPassword=request.form("userPassword")
    
    sql="select 유저.고유번호 as 유저, 관리자.고유번호 as 관리자, "_
    & "소유자.고유번호 as 소유자, 사용자.고유번호 as 사용자 "_
    & "from 유저 left outer join 관리자 "_ 
    & "on 유저.고유번호=관리자.고유번호 "_
    & "left outer join 소유자 "_
    & "on 유저.고유번호=소유자.고유번호 "_
    & "left outer join 사용자 "_
    & "on 유저.고유번호=사용자.고유번호 "_
    & "where 아이디='" & userID & "' "_ 
    & "and 비밀번호='" & userPassword & "'"

    Set Rs=Dbcon.Execute(sql)

    if Rs.BOF then
        Dbcon.Close()
        Set Dbcon=Nothing
        Set Rs=Nothing
        response.redirect("404.html")
    else
        session("userID")=userID

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
