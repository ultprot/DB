<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID


  sql="select 구청.구_명칭,max(관리기록.관리일자) as  최근관리일자,주차장.주차장_번호,주차장.구청_관리주기, "_
  & "DATEADD(day,주차장.구청_관리주기,max(관리기록.관리일자)) as 다음관리일자 "_
  & "from 구청 join 관리기록 on 구청.구청_고유번호=관리기록.구청_고유번호 "_
  & "join 주차장 on 관리기록.주차장_번호=주차장.주차장_번호 "_
  & "group by 구청.구_명칭,주차장.주차장_번호,주차장.구청_관리주기 "_
  & "order by 구청.구_명칭"

  Set Rs=Dbcon.Execute(sql)
%>

<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          관리일자 확인
        </li>
      </ol>

      <div class="container">
        <h2>구청 별 다음 관리일자 확인</h2>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>구 명칭</th>
              <th>최근 관리일자</th>
              <th>주차장 번호</th>
              <th>구청 관리주기</th>
			  <th>다음 관리일자</th>
            </tr>
          </thead>
          <tbody>
            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("구_명칭"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("최근관리일자"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("주차장_번호"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("구청_관리주기"))
                                response.write("</td>")
								response.write("<td>")
                                response.write(Rs("다음관리일자"))
                                response.write("</td>")
                                response.write("</tr>")
                                Rs.movenext
                            Loop
                            %>
          </tbody>
        </table>
        
        
      </div>
    <div class="d-flex justify-content-around">
    

    </div>
    </div>
    <!-- /.container-fluid -->
    <!-- The Modal -->
    
</div>
<%
  Dbcon.Close()
  Set Dbcon=Nothing
  Set Rs=Nothing
%>
<!-- /.content-wrapper -->
<!--#include virtual="./footer.asp"-->
