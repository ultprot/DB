<!--#include virtual="./header.asp"-->
<%
  Set Dbcon=Server.CreateObject("ADODB.Connection")
  Dbcon.Open Application("dbConnect")
  
  Dim userID

  userID=session("userID")

  sql="Select 유저.아이디,DATEPART(mm, 사용이력.주차종료시간) as 월, "_
  & "sum(사용이력.납부한_요금) as 월별총합납부요금 "_
  & "From 유저 join 소유자 on 유저.고유번호=소유자.소유자_고유번호 "_
  & "join 주차장 on 소유자.소유자_고유번호= 주차장.소유자_고유번호 "_
  & "join 사용이력 on 주차장.주차장_번호=사용이력.주차장_번호 "_
  & "group by 유저.아이디,DATEPART(mm, 사용이력.주차종료시간) "_
  & "having DATEPART(mm, 사용이력.주차종료시간) is not null and 유저.아이디 = '" & userID & "'"_
  & "order by DATEPART(mm, 사용이력.주차종료시간) "

  Set Rs=Dbcon.Execute(sql)
%>

<div id="content-wrapper">

    <div class="container-fluid">

      <!-- Breadcrumbs-->
      <ol class="breadcrumb">
        <li class="breadcrumb-item">
          소유자
        </li>
      </ol>

      <div class="container">
        <h2>소유자 수입</h2>
        <table class="table table-bordered">
          <thead>
            <tr>
              <th>아이디</th>
              <th>월</th>
              <th>월별 수입</th>
            </tr>
          </thead>
          <tbody>
            <%
                            do while not(Rs.EOF)
                                response.write("<tr>")
                                response.write("<td>")
                                response.write(Rs("아이디"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("월"))
                                response.write("</td>")
                                response.write("<td>")
                                response.write(Rs("월별총합납부요금"))
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
