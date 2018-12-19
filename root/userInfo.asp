<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session.contents("userID")

  sql="select 유저.고유번호, 아이디, 비밀번호, 전화번호, 생년월일, "_
  & "근무_시작시간, 근무_종료시간, 근무_시작기간, 근무_종료기간, "_
  & "계좌 "_
  & "from 유저 left outer join 관리자 "_ 
  & "on 유저.고유번호=관리자.관리자_고유번호 "_
  & "left outer join 소유자 "_
  & "on 유저.고유번호=소유자.소유자_고유번호 "_
  & "left outer join 사용자 "_
  & "on 유저.고유번호=사용자.사용자_고유번호 "_
  & "where 아이디='" & userID &"'"

  Set Rs=Dbcon.Execute(sql)
%>

<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          사용자 정보
        </li>
      </ol>

      <div class="container">
        <h2>기본 정보</h2>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>아이디</th>
              <th>비밀번호</th>
              <th>전화번호</th>
              <th>생년월일</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><%=Rs("아이디")%></td>
              <td><%=Rs("비밀번호")%></td>
              <td><%=Rs("전화번호")%></td>
              <td><%=Rs("생년월일")%></td>
            </tr>
          </tbody>
        </table>
        <%
        if session("isManager") then
        response.write("<h3>관리자 정보</h3>")
        response.write("<table class=""table table-bordered"">")
        response.write("<thead>")
        response.write("<tr>")
        response.write("<th>근무시작시간</th>")
        response.write("<th>근무종료시간</th>")
        response.write("<th>근무시작기간</th>")
        response.write("<th>근무종료기간</th>")
        response.write("</tr>")
        response.write("</thead>")
        response.write("<tbody>")
        response.write("<tr>")
          
        response.write("<td>")  
        response.write(Rs("근무_시작시간"))
        response.write("</td><td>")
        response.write(Rs("근무_종료시간"))
        response.write("</td><td>")
        response.write(Rs("근무_시작기간"))
        response.write("</td><td>")
        response.write(Rs("근무_종료기간"))
        response.write("</td></tr>")
        response.write("</tbody></table>")
        end if
        %>
        <%
        if session("isOwner") then
        response.write("<h3>소유자 정보</h3>")
        response.write("<table class=""table table-bordered"">")
        response.write("<thead>")
        response.write("<tr>")
        response.write("<th>계좌번호</th>")
        response.write("</tr>")
        response.write("</thead>")
        response.write("<tbody>")
        response.write("<tr>")
         
        response.write("<td>")  
        response.write(Rs("계좌"))
        response.write("</td>")
        response.write("</tr>")
        response.write("</tbody></table>")
        end if
        %>
      </div>
    <div class="d-flex justify-content-around">
    <%
    if not session("isManager") then
      response.write("<a href=""newManager.asp""><button class=""btn btn-secondary"">관리자 활성화</button></a>")
    end if
    if not (session("isOwner")) then
      response.write("<button class=""btn btn-secondary"" data-toggle=""modal"" data-target=""#ownerModal"">소유자 활성화</button>")
    end if
    %>

    </div>
    </div>
    <!-- /.container-fluid -->
    <!-- The Modal -->
    <div class="modal" id="ownerModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">소유자 정보 추가</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <form action="newOwner.asp" method="post">
                        <div class="form-group">
                            <label for="Account">계좌</label>
                            <input type="text" class="form-control" id="Account" name="Account">
                        </div>
                        <button type="submit" class="btn btn-primary">등록</button>
                    </form>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
</div>
<%
  Dbcon.Close()
  Set Dbcon=Nothing
  Set Rs=Nothing
%>
<!-- /.content-wrapper -->
<!--#include virtual="./footer.asp"-->
