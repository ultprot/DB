<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session.contents("userID")

  sql="select 유저.아이디, 리뷰.리뷰_번호, 리뷰.평점, 리뷰.내용, 리뷰.주차장번호, 리뷰.고유번호 "_
  & "from 리뷰 join 사용자 on 리뷰.고유번호= 사용자.고유번호 "_ 
  & "join 주차장 on 리뷰.주차장번호=주차장.주차장번호 "_
  & "join 유저 on 유저.고유번호=사용자.고유번호 "_
  & "where 유저.아이디 = '" & userID & "'"

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
        <div class="card mb-3">
            <div class="card-header">
                <i class="fas fa-table"></i>
                내가 쓴 리뷰
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                            <th>리뷰번호</th>
                            <th>평점</th>
                            <th>내용</th>
                            <th>주차장 번호</th>
                            <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("리뷰_번호"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("평점"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("내용"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("주차장번호"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write("<form action=""#"" method=""post"">")
                                response.write("<button type=""submit"" class=""btn btn-secondary"">삭제</button>")
                                response.write("</form>")
                                response.write("</td>")
                                response.write("</tr>")
                                Rs.movenext
                            Loop
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
      </div>

    </div>
    <!-- /.container-fluid -->
</div>
<%
  Dbcon.Close()
  Set Dbcon=Nothing
  Set Rs=Nothing
%>
<!-- /.content-wrapper -->
<!--#include virtual="./footer.asp"-->
