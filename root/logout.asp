<%
    session.contents.remove("userID")
    session.contents.remove("isManager")
    session.contents.remove("isOwner")
    session.contents.remove("isNormal")
    response.redirect "main.html"
%>
