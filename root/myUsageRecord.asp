<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session.contents("userID")

  sql="select 유저.아이디, 사용이력.고유번호, 사용이력.주차장번호, "_
  & "사용이력.주차_시작시간, 사용이력.주차_종료시간, 사용이력.총_요금, 사용이력.납부요금 "_
  & "from 사용이력 join 사용자 on 사용이력.고유번호=사용자.고유번호 "_ 
  & "join 유저 on 유저.고유번호 = 사용자.고유번호 "_
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
        <h2>내 사용 기록</h2>
        <div class="card mb-3">
            <div class="card-header">
              <i class="fas fa-table"></i>
              Data Table Example</div>
            <div class="card-body">
              <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                            <th>주차장 번호</th>
                            <th>주차 시작시간</th>
                            <th>주차 종료시간</th>
                            <th>총 요금</th>
                            <th>납부요금</th>
                            <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("주차장번호"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("주차_시작시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("주차_종료시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("총_요금"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("납부요금"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write("<form action=""#"" method=""post"">")
                                response.write("<button type=""submit"" class=""btn btn-secondary"">납부</button>")
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
            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
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
