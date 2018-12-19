<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")

  Dim parkNumber
  parkNumber=request.querystring("parkNumber")

  sql="select 리뷰.리뷰번호 as 리뷰번호, 리뷰.평점, 리뷰.내용 "_
  & "from 리뷰 join 주차장 on 리뷰.주차장_번호 = 주차장.주차장_번호 "_ 
  & "where 주차장.주차장_번호 = " & parkNumber & ";"

  Set Rs=Dbcon.Execute(sql)
%>

<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          주차장 <%=parkNumber%> 정보
        </li>
      </ol>

      <div class="container">
        <div class="card mb-3">
            <div class="card-header">
                <i class="fas fa-table"></i>
                주차장 리뷰
            </div>
            <div class="card-body">
                <div class="table-responsive">
                    <table class="table table-bordered" id="dataTable">
                        <thead>
                            <tr>
                            <th>평점</th>
                            <th>내용</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("평점"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("내용"))
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
