<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID
  Dim placeID
  userID=session.contents("userID")
  placeID=request.QueryString("parkingPlaceNumber")

  sql="select 자리.자리번호,cast(자리.현재_사용여부 as int) as 사용여부,자리.이용대상,자리.가로크기,자리.세로크기 "_
  & "from 자리 join 주차장 on 자리.주차장번호=주차장.주차장번호 "_ 
  & "where 주차장.주차장번호 = '" & placeID & "'"

  Set Rs=Dbcon.Execute(sql)
%>

<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          관리자 정보
        </li>
      </ol>

      <div class="container">
        <div class="card mb-3">
            <div class="card-header">
                <i class="fas fa-table"></i>
                주차장 정보
            </div>
            <div class="card-body">
                <div class="table-responsive"> 
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                                <th>자리번호</th>
                                <th>사용여부</th>
                                <th>이용대상</th>
                                <th>가로크기</th>
                                <th>세로크기</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("자리번호"))
                                response.write("</td>")
                                response.write("<td>")
                                if Rs("사용여부")=0 then
                                    response.write("사용 가능")
                                else 
                                    response.write("사용 중")
                                end if
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("이용대상"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("가로크기"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("세로크기"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write("<form action=""#"" method=""post"">")
                                response.write("<button type=""submit"" class=""btn btn-secondary"">변경</button>")
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
    <!-- The Modal -->
    <div class="modal" id="myModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">주차장 추가</h4>
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
