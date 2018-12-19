<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session.contents("userID")

  sql="select 주차장.주차장번호, 주차장.주소, 주차장.종류, 주차장.최대이용시간, 주차장.개장시간, 주차장.폐장시간, "_
  & "주차장.총_자리_수, 주차장.현재_자리_수 "_
  & "from 주차장 join 관리자 on 주차장.고유번호=관리자.고유번호 "_ 
  & "join 유저 on 관리자.고유번호=유저.고유번호 "_
  & "where 유저.아이디 = '" & userID & "'"

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
        <div class="d-flex justify-content-end">
            <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#myModal">
                추가
            </button>
        </div>
        <div class="card mb-3">
            <div class="card-header">
                <i class="fas fa-table"></i>
                관리 주차장
            </div>
            <div class="card-body">
                <div class="table-responsive"> 
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                                <th>주차장번호</th>
                                <th>주소</th>
                                <th>종류</th>
                                <th>최대 이용시간</th>
                                <th>개장시간</th>
                                <th>폐장시간</th>
                                <th>총 자리 수</th>
                                <th>현재 자리 수</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write("<a href=""parkingPlaceInfo.asp?parkingPlaceNumber=")
                                response.write(Rs("주차장번호"))
                                response.write(""">")
                                response.write("현황")
                                response.write("</a>")
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("주소"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("종류"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("최대이용시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("개장시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("폐장시간"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("총_자리_수"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("현재_자리_수"))
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
