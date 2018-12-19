<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session.contents("userID")

  sql="select 차량.* "_
  & "from 차량 join 차량소유 on 차량.차량번호=차량소유.차량번호 "_ 
  & "join 사용자 on 차량소유.사용자_고유번호=사용자.사용자_고유번호 "_
  & "join 유저 on 사용자.사용자_고유번호=유저.고유번호 "_
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
        <div class="d-flex justify-content-end">
            <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">
                추가
            </button>
        </div>
        <div class="card mb-3">
            <div class="card-header">
                <i class="fas fa-table"></i>
                소유차량
            </div>
            <div class="card-body">
                <div class="table-responsive"> 
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                                <th>차종</th>
                                <th>차량번호</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                if Rs("차종")=0 then
                                    response.write("소형")
                                elseif Rs("차종")=1 then
                                    response.write("중형")
                                elseif Rs("차종")=2 then
                                    response.write("대형")
                                end if
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("차량번호"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write("<a href=""carDelete.asp?" & "carNumber=" & Rs("차량번호") & """>")
                                response.write("삭제</a>")
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
                    <form action="carAdd.asp" method="post">
                        <div class="form-group">
                            <label for="type">차종</label>
                            <input type="text" class="form-control" id="type" name="type">
                        </div>
                        <div class="form-group">
                            <label for="number">차량 번호</label>
                            <input type="text" class="form-control" id="number" name="number">
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
