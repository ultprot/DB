<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session.contents("userID")

  sql="select 유저.아이디, 차량.차종, 차량.차량번호, 차량.고유번호 "_
  & "from 차량 join 사용자 on 차량.고유번호= 사용자.고유번호 "_ 
  & "join 유저 on 유저.고유번호= 사용자.고유번호 "_
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
        <h2>소유 차량</h2>
        <div class="d-flex justify-content-end">
            <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">
                추가
            </button>
        </div>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>차종</th>
              <th>차량번호</th>
              <th>고유번호</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <%
            do while not(Rs.EOF)
                response.write("<tr>")
                response.write("<td>")
                response.write(Rs("차종"))
                response.write("</td>")
                response.write("<td>")
                response.write(Rs("차량번호"))
                response.write("</td>")
                response.write("<td>")
                response.write(Rs("고유번호"))
                response.write("</td>")
                response.write("<td>")
                response.write("</td>")
                response.write("</tr>")
                Rs.movenext
            Loop
            %>
          </tbody>
        </table>
      </div>

    </div>
    <!-- /.container-fluid -->
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">차량 추가</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <form action="addCar.asp" method="post">
                            <div class="form-group">
                                <label for="type">차종</label>
                                <input type="text" class="form-control" id="type">
                            </div>
                            <div class="form-group">
                                <label for="number">차량 번호</label>
                                <input type="text" class="form-control" id="number">
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
